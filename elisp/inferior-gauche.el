;; Subject: inferior-gauche.el
;; History: 2004-07-04 15:58:42 << 2003-07-16 11:09:47
;; ----

;; (setq debug-on-error t)
;; Gauche 側で入力待ちになった場合の対処を．

(require 'scheme)
(require 'info-look)

;; User Variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar ig-gosh "gosh")
(defvar ig-gosh-args "")
(defvar ig-buffer-local-p nil)
;; make processes buffer-local or not.

;; Internal Variables ;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar ig-process-name "gosh")
(defvar ig-error-regexp (concat "^" (regexp-quote "*** ERROR: ")))
(defvar ig-gosh-prompt "gosh> ")
(defvar ig-error-buffer-name " * Gauche Error*")
(defvar ig-temp-buffer-name " * IG TEMP*")
(defvar ig-process nil)
;; Store a process when ig-buffer-local-p is nil.
(defvar ig-error-buffers nil)
;; Error message.
;; ((process . error-buffer) ... )
(defvar ig-temp-buffers nil)
;; Output buffer.
;; ((process . temp-buffer) ... )
(defvar ig-output-streams nil)
;; ((process stream-type . stream) ... )
;; stream-type: buffer, message, completion, ... (symbol)
;; stream: buffer, ... (object)
(defvar ig-mode-line-format
  (if (member 'mode-line-process (reverse default-mode-line-format))
      (append
       (reverse (cdr (member 'mode-line-process (reverse default-mode-line-format))))
       '((:eval (ig-mode-line-process)))
       (member 'mode-line-process default-mode-line-format))
    default-mode-line-format))
(defvar ig-syntax-table (let ((syntax (copy-syntax-table scheme-mode-syntax-table)))
                          (modify-syntax-entry ?\| "  2b3" syntax)
                          (modify-syntax-entry ?# "_ p14b" syntax)
                          syntax))
(defvar ig-font-lock-keywords
  (append
   scheme-font-lock-keywords-1
   scheme-font-lock-keywords-2
   `((,(format "(%s\\>"
               (regexp-opt
                '("when" "unless" "dotimes" "dolist" "let1"
                  "let*-values" "let-values" "let-optionals*"
                  "let-keywords*" "receive" "begin0"
                  "define-reader-ctor" "define-constant"
                  "let-args" "parse-options") t))
      1 font-lock-keyword-face)
     (,(format "(%s\\>"
               (regexp-opt
                '("error" "syntax-error" "errorf") t)) 1 font-lock-warning-face)
     ("\\<<>\\>" . font-lock-builtin-face))))
(mapcar '(lambda (s)
           (put (car s) 'scheme-indent-function (cdr s)))
        '((if . 2) (dotimes . 1)
          (dolist . 1) (for . 1)
          (let-values . 1) (let*-values . 1)
          (let-optionals* . 2) (let-keywords* . 2)
          (let1 . 2)
          (let-args . 2)
          (when . 1) (unless . 1)
          (set! . 2) (receive . 1)
          (begin0 . 1)))
;;(defvar inferior-gauche-mode-map (let ((map (make-sparse-keymap)))
(setq inferior-gauche-mode-map (let ((map (make-sparse-keymap)))
                                   (set-keymap-parent map scheme-mode-map)
                                   (define-key map [?\C-\M-x] 'ig-eval-define)
                                   (define-key map [?\C-x ?\C-e] 'ig-eval-last-sexp)
                                   (define-key map [?\C-j] 'ig-eval-print-last-sexp)
                                   (define-key map [?\C-c ?\C-s] 'ig-start-process)
                                   (define-key map [?\M-\C-i] 'ig-complete-symbol)
                                   (define-key map [?\C-c ?\C-d] 'ig-insert-debug-print)
                                   (define-key map [?\C-c ?\C-c] 'ig-interrupt-process)
                                   (define-key map [?\C-c ?\C-q] 'ig-exit-process)
                                   (define-key map [?\C-c ?\C-v] 'ig-eval-buffer)
                                   map))

;; Functions

(define-derived-mode inferior-gauche-mode scheme-mode
  "Inferior Gauche" "Major mode for Gauche."
  (set-syntax-table ig-syntax-table)
  (setq mode-line-format ig-mode-line-format
        comment-start ";;"
        font-lock-defaults
        `(,ig-font-lock-keywords
          nil t (("+-*/.<>=!?$%_&~^:" . "w")) beginning-of-defun
          (font-lock-mark-block-function . mark-defun)))
  (ig-start-process))

(defun ig-mode-line-process ()
  (if (eq major-mode 'inferior-gauche-mode)
      (if (ig-process-live-p)
          (if ig-buffer-local-p
              (format " [%s: %s]" (process-name (ig-get-process))
                      (process-status (ig-get-process)))
            (format " [%s]" (process-status (ig-get-process))))
        " [no process]")
    ""))

(defun ig-get-process (&optional buffer)
  (unless buffer
    (setq buffer (current-buffer)))
  (if (get-buffer-process buffer)
      (get-buffer-process buffer)
    (when (not ig-buffer-local-p)
      ig-process)))

(defun ig-process-live-p (&optional p)
  (let ((proc (or p (ig-get-process))))
    (and proc (member (process-status proc)
                      '(run stop)))))

(defmacro ig-set (var)
  `(let ((old (assoc proc ,var)))
     (setq ,var
           (if element
               (cons (cons proc element) (delete old ,var))
             (delete old ,var)))))

(defmacro ig-get (var)
  `(cdr (assoc proc ,var)))

(defun ig-set-output-stream (proc element)
  (ig-set ig-output-streams))

(defun ig-get-output-stream (proc)
  (ig-get ig-output-streams))

(defun ig-set-temp-buffer (proc element)
  (ig-set ig-temp-buffers))

(defun ig-get-temp-buffer (proc)
  (ig-get ig-temp-buffers))

(defun ig-set-error-buffer (proc element)
  (ig-set ig-error-buffers))

(defun ig-get-error-buffer (proc)
  (ig-get ig-error-buffers))

(defun ig-start-process ()
  (interactive)
  (unless (ig-process-live-p)
    (let* ((process-connection-type t)
           (buffer (when ig-buffer-local-p
                     (current-buffer)))
           (proc (if (and ig-gosh-args (< 0 (length ig-gosh-args)))
                     (start-process ig-process-name buffer ig-gosh
                                    ig-gosh-args)
                   (start-process ig-process-name buffer ig-gosh))))
      (set-process-filter proc 'ig-filter)
      (set-process-sentinel proc 'ig-process-msg)
      (process-kill-without-query proc nil)
      (ig-set-output-stream proc nil)
      (unless ig-buffer-local-p
        (setq ig-process proc))
      (message "%s: start" (process-name proc)))))

(defun ig-delete-last-newline (string)
  (when (and (< 0 (length string)) (= ?\n (aref string (- (length string) 1))))
    (setq string (substring string 0 (- (length string) 1))))
  string)

(defmacro when-process-accessible (&rest body)
  `(if (ig-process-live-p)
       (if (ig-get-output-stream (ig-get-process))
           (message "%s is busy." (process-name (ig-get-process)))
         ,@body)
     (message "No Process running.")))

(defun ig-eval-print-last-sexp ()
  (interactive)
  (when-process-accessible
   (let ((end (point))
         (beg (save-excursion
                (backward-sexp 1)
                (point)))
         (proc (ig-get-process)))
     (ig-set-output-stream proc (cons 'buffer (current-buffer)))
     (process-send-string proc
                          (concat (buffer-substring-no-properties beg end) "\n"))
     (catch 'ig-print-done
       (while (ig-process-live-p proc) (accept-process-output proc))))))

(defun ig-eval-last-sexp ()
  (interactive)
  (when-process-accessible
   (let ((end (point))
         (beg (save-excursion
                (backward-sexp 1)
                (point)))
         (proc (ig-get-process)))
     (ig-set-output-stream proc '(message))
     (process-send-string proc
                          (concat (buffer-substring-no-properties beg end) "\n")))))

(defun ig-eval-region (beg end)
  (interactive "r")
  (when-process-accessible
   (let ((proc (ig-get-process)))
     (ig-set-output-stream proc '(message))
     (process-send-string proc
                          (concat "(begin \n"
                                  (buffer-substring-no-properties beg end)
                                  "\n)\n")))))

(defun ig-eval-buffer ()
  (interactive)
  (save-restriction
    (widen)
    (ig-eval-region (point-min) (point-max))))

(defun ig-eval-define ()
  (interactive)
  (save-excursion
    (ig-eval-region (save-excursion (beginning-of-defun)
                                    (point))
                    (save-excursion (end-of-defun)
                                    (point)))))

(defmacro ig-clean-up-macro (var &optional buff-p)
  `(setq ,var
         (delete nil
                 (mapcar '(lambda (el)
                            (if (ig-process-live-p (car el))
                                el
                              (when (and ,buff-p
                                         (bufferp (cdr el))
                                         (buffer-live-p (cdr el)))
                                (kill-buffer (cdr el)))
                              nil))
                         ,var))))

(defmacro ig-clean-up ()
  (ig-clean-up-macro ig-error-buffers t)
  (ig-clean-up-macro ig-temp-buffers t)
  (ig-clean-up-macro ig-output-streams))

(defun ig-process-msg (proc event)
  (ig-clean-up)
  (message "%s: %s" (process-name proc)
           (ig-delete-last-newline event)))

(defun ig-filter (proc out)
  (let ((tbuf (let ((proc-temp-buf (ig-get-temp-buffer proc)))
                (if (buffer-live-p proc-temp-buf)
                    proc-temp-buf
                  (let ((new-temp-buf (generate-new-buffer ig-temp-buffer-name)))
                    (ig-set-temp-buffer proc new-temp-buf)
                    new-temp-buf)))))
    (set-buffer tbuf)
    (goto-char (point-max))
    (insert out)
    (let ((last-line (buffer-substring (line-beginning-position)
                                       (line-end-position)))
          (last-line-point (max (- (line-beginning-position) 1)
                                (point-min))))
      (when (string= last-line ig-gosh-prompt)
        (let ((output (buffer-substring (point-min) last-line-point))
              (stream-type (car (ig-get-output-stream proc)))
              (stream (cdr (ig-get-output-stream proc))))
          (erase-buffer)
          (unwind-protect
              (save-match-data
                (if (string-match ig-error-regexp output)
                    (progn
                      (ig-error proc output)
                      (when (bufferp stream)
                        (throw 'ig-print-done nil)))
                  (when (< 0 (length output))
                    (cond ((eq stream-type 'buffer)
                           (set-buffer stream)
                           (insert ?\n output ?\n)
                           (throw 'ig-print-done nil))
                          ((eq stream-type 'completion)
                           (ig-complete-symbol-body proc output))
                          (t (princ output))))))
            (ig-set-output-stream proc nil)))))))

(defun ig-error (porc error-string)
  (let ((err-buf (let ((proc-err-buf (ig-get-error-buffer proc)))
                   (if (buffer-live-p proc-err-buf)
                       proc-err-buf
                     (let ((new-err-buf (generate-new-buffer ig-error-buffer-name)))
                       (ig-set-error-buffer proc new-err-buf)
                       new-err-buf)))))
    (set-buffer err-buf)
    (erase-buffer)
    (insert error-string)
    (unless (get-buffer-window err-buf)
      (display-buffer err-buf))))

(defun ig-regexp-escape-filter (string)
  (save-match-data
    (setq string (replace-regexp-in-string "\\+" "\\\\+" string))
    (setq string (replace-regexp-in-string "\\." "\\\\." string))
    (setq string (replace-regexp-in-string "\\*" "\\\\*" string))))

(defun ig-complete-symbol ()
  (interactive)
  (when-process-accessible
   (let ((end (point))
         (beg (max (line-beginning-position)
                   (save-excursion
                     (backward-sexp 1)
                     (point))))
         (proc (ig-get-process)))
     (unless (= beg end)
       (ig-set-output-stream proc (cons 'completion (current-buffer)))
       (process-send-string proc
                            (format "(apropos #/^%s/)\n"
                                    (ig-regexp-escape-filter
                                     (buffer-substring-no-properties beg end))))))))

(defun ig-complete-symbol-body (proc string)
  (set-buffer (cdr (ig-get-output-stream proc)))
  (let* ((collection (mapcar '(lambda (el)
                                (cons
                                 (replace-regexp-in-string
                                  "\\(^|\\||$\\)" ""
                                  (replace-regexp-in-string " +(.*)$" "" el))
                                 nil))
                             (split-string string "\n")))
         (end (point))
         (beg (max (line-beginning-position)
                   (save-excursion
                     (backward-sexp 1)
                     (point))))
         (orig (buffer-substring beg end))
         (comp (try-completion orig collection)))
    (when (stringp comp)
      (delete-region beg end)
      (insert comp)
      (when (string= orig comp)
        (with-output-to-temp-buffer "*Completions*"
          (display-completion-list
           (all-completions orig collection)))))))

(defun ig-interrupt-process ()
  (interactive)
  (ig-clean-up-macro ig-output-streams)
  (interrupt-process (ig-get-process)))

(defun ig-exit-process ()
  (interactive)
  (ig-clean-up-macro ig-output-streams)
  (when-process-accessible
   (process-send-string (ig-get-process)
                        "(exit)\n")))

(defun ig-insert-debug-print (arg)
  (interactive "P")
  (if arg
      (save-match-data
        (save-excursion
          (save-restriction
            (end-of-defun)
            (let ((end (point)))
              (beginning-of-defun)
              (narrow-to-region (point) end)
              (replace-string "#?=" "")))))
    (insert "#?=")))

(info-lookup-add-help
 :topic 'symbol
 :mode 'inferior-gauche-mode
 :regexp "[^()'\"  \n]+"
 :ignore-case t
 :doc-spec '(("(gauche-refj.info)Index - 手続きと構文索引" nil
              "^[  ]+- [^:]+:[  ]*" "\\b")
             ("(gauche-refj.info)Index - モジュール索引" nil
              "^[  ]+- [^:]+:[  ]*" "\\b")
             ("(gauche-refj.info)Index - クラス索引" nil
              "^[  ]+- [^:]+:[  ]*" "\\b")
             ("(gauche-refj.info)Index - 変数索引" nil
              "^[  ]+- [^:]+:[  ]*" "\\b"))
 :parse-rule nil
 :other-modes nil)

(provide 'inferior-gauche)
;;; inferior-gauche.el ends here
