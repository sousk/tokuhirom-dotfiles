;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cperl-mode settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use cperl mode instead of the default perl mode
(defalias 'perl-mode 'cperl-mode)

(setq auto-mode-alist
      (cons (cons "\\.t$" 'cperl-mode)
	    auto-mode-alist))

;; based on miyagawa's settings
(add-hook 'cperl-mode-hook
          (lambda ()
            (define-key cperl-mode-map "\M-."  'cperl-find-module)
            (define-key cperl-mode-map "\C-ct" 'perltidy-region)
	    (define-key cperl-mode-map "\C-m"  'newline-and-indent)
            (setq cperl-auto-newline t)
            ;; Use 4 space indents via cperl mode
            (setq cperl-close-paren-offset -4)
            (setq cperl-indent-level 4)
            (setq cperl-label-offset -4)
            (setq cperl-continued-statement-offset 4)
            (setq cperl-indent-parens-as-block t)
            (setq indent-tabs-mode nil)
	    (abbrev-mode 1)
            ;; (setq cperl-invalid-face nil)
            (setq cperl-highlight-variables-indiscriminately t)))

;; source reindent by perltidy
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))

;; find perl module's source code
;; ref. http://d.hatena.ne.jp/tokuhirom/20060204/1139061383
(defun cperl-find-module (module)
  (interactive (list (let* ((default-entry (cperl-word-at-point))
                (input (read-string
                        (format "perldoc entry%s: "
                                (if (string= default-entry "")
                                    ""
                                  (format " (default %s)" default-entry))))))
           (if (string= input "")
               (if (string= default-entry "")
                   (error "No perldoc args given")
                 default-entry)
             input))))
  (if (string= module "")
      (message "No module name found at this point.")
    (let (perldoc-output exit-status)
      (with-temp-buffer
        (setq exit-status (call-process "perldoc" nil t nil "-lm" module))
        (goto-char (point-min))
        (setq perldoc-output (buffer-substring (point-at-bol)
                                               (point-at-eol))))
      (if (not (zerop exit-status))
          (message "No module found for \"%s\"." module)
        (find-file-other-window perldoc-output)))))

(defun cperl-find-module-at-point ()
  (interactive)
  (cperl-find-module (cperl-word-at-point)))
