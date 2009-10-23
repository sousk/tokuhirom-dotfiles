;;
;; hogememo
;;
;;   presented by tak@st.rim.or.jp
;; 
;; how to setup:  add 2 lines in your ~/.emacs
;;   (autoload 'hogememo "hogememo" "HogeMemo" t nil)
;;   (define-key esc-map "m" 'hogememo)

(defconst hogememo-version "hogememo.el 0.6")

;; Variables for customizing
(defvar hogememo-spool-directory "~/Memo"
  "*Directory to keep memo*")

(defvar hogememo-make-filename-function 'hogememo-make-filename
  "*Function to make a filename string from an argument.")

(defvar hogememo-startup-hook nil
  "*A hook called at start up time.")

;; Variables for internal use
(defvar hogememo-input-map nil)
(defvar hogememo-current-buffer nil)
(defvar hogememo-current-memo-nprevs nil)
(defvar hogememo-before-window-configuration nil)

;; Constants
(defconst hogememo-month-alist '(
  ("Jan"  1)
  ("Feb"  2)
  ("Mar"  3)
  ("Apr"  4)
  ("May"  5)
  ("Jun"  6)
  ("Jul"  7)
  ("Aug"  8)
  ("Sep"  9)
  ("Oct" 10)
  ("Nov" 11)
  ("Dec" 12)
))
(defconst hogememo-dayname-alist '(
  ("Sun"  1)
  ("Mon"  2)
  ("Tue"  3)
  ("Wed"  4)
  ("Thu"  5)
  ("Fri"  6)
  ("Sat"  7)
))
(defconst hogememo-waste-line-regexp "^\\(>?[ \t]*\\|\* .*\\)$")

;;
;; Functions
;;

(defun hogememo-get-dates-list (tim)
  ; return: (yyyy mm dd hh mm ss dn)
  (list
    (string-to-number (substring tim 20 24))
    (nth 1 (assoc (substring tim 4 7) hogememo-month-alist))
    (string-to-number (substring tim 8 10))
    (string-to-number (substring tim 11 13))
    (string-to-number (substring tim 14 16))
    (string-to-number (substring tim 17 19))
    (nth 1 (assoc (substring tim 0 3) hogememo-dayname-alist))
  )
)

(defun hogememo-make-date-string ()
  (format-time-string "%Y/%m/%d(%a) %H:%M:%S")
)

(defun hogememo-make-filename () (format-time-string "%Y.txt"))

(defun hogememo-get-create-spool-directory ()
  (let ((path (file-name-as-directory
            (expand-file-name hogememo-spool-directory))))
    (if (file-exists-p path)
      nil
      ;else
      (message "hogememo: making directory %s..." path)
      (make-directory path)
      (set-file-modes path 448)
      (message "hogememo: directory has made.")
    )
    path
  )
)

(defun hogememo-erase-waste-footer ()
  (let (ps pe pq str)
    (end-of-buffer)
    (if (not (bolp)) (insert "\n"))
    (while (not (bobp))
      (setq pe (point))
      (next-line -1)
      (beginning-of-line)
      (setq ps (point))
      (end-of-line)
      (setq pq (point))
      (setq str (buffer-substring ps pq))
      (if (string-match hogememo-waste-line-regexp str)
        (delete-region ps pe)
        (beginning-of-buffer)
      )
    )
  )
)

(defun hogememo-get-buffer-name ()
   (concat
     (hogememo-get-create-spool-directory)
     (funcall hogememo-make-filename-function)
   )
)

(defun hogememo-get-current-buffer ()
  (save-excursion
    (if (buffer-name hogememo-current-buffer)
      hogememo-current-buffer
      ;else
      (get-file-buffer (hogememo-get-buffer-name))
    )
  )
)

(defun hogememo-save-and-kill-buffer ()                                         
  (interactive)
  (if buffer-read-only                                                          
    (message "memo is read-only.")                                                  ;else                                                                       
    (hogememo-erase-waste-footer)                                               
    (beginning-of-buffer)                                                       
    (if (not (eobp))                                                            
      (save-buffer)                                                             
      ;else                                                                     
      (set-buffer-modified-p nil)                                               
      (message "memo is empty.")                                                
    )                                                                           
  )                                                                             
  (kill-buffer (current-buffer))                                                
)

;;
;; User Interface
;;

(defun hogememo-insert-header ()
  (interactive)
  (let ((b (hogememo-get-current-buffer)))
    (if b (progn
      (set-buffer b)
      (hogememo-erase-waste-footer)
      (end-of-buffer)
      (insert "\n")
      (if (not (bobp)) (insert "\n"))
      (insert (concat "* " (hogememo-make-date-string) "\n\n"))
      (save-excursion (insert "\n\n\n"))
    ))
  )
)

(defvar hogememo-map (make-sparse-keymap))

(defun hogememo (&optional arg)
  "Open current memo text and prepare to write."
  (interactive "P")
  (let ((dates (hogememo-get-dates-list (current-time-string)))
        fn
        b
       )
    (if (not (null hogememo-before-window-configuration))
      nil ;nothing to do
      ;else
      (if (and (not (one-window-p t nil)) (< (window-height) 6))
        (progn
          (setq hogememo-before-window-configuration
            (current-window-configuration))
          (delete-window)
        )
        (setq hogememo-before-window-configuration nil)
      )
    )
    (setq b (hogememo-get-current-buffer))
    (if (and (not b) hogememo-current-memo-nprevs)
      (progn
        (setq hogememo-current-memo-nprevs nil)
        (setq b (hogememo-get-current-buffer))
      )
    )
    (setq fn (hogememo-get-buffer-name))
    (if (not b)
      (find-file fn)
      ;else
      (set-buffer b)
      (switch-to-buffer b)
      (if (string= buffer-file-name fn)
        nil
        ;else ... close and reopen
        (hogememo-save-and-kill-buffer)
        (setq hogememo-current-memo-nprevs nil)
        (setq fn (hogememo-get-buffer-name))
        (find-file fn)
      )
    )
    (if hogememo-current-memo-nprevs
      nil  ;read only mode
      ;else
      (hogememo-erase-waste-footer) ;; いったんヘッダけす
      (end-of-buffer)
      ;; ヘッダいれる
      (let ((p (buffer-modified-p)))
	(if (not (bobp)) (insert "\n"))
	(insert (concat "* " (hogememo-make-date-string) "\n"))
	(insert "\n")
	(set-buffer-modified-p p)
        )
    )
    ;
    (setq hogememo-current-buffer (current-buffer))
    (message "hoge-: %s" fn)
    (run-hooks 'hogememo-startup-hook)
   )
)
