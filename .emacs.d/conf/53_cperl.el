;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cperl-mode settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'cperl-mode "cperl-mode" "" t)

;; Use cperl mode instead of the default perl mode
(defalias 'perl-mode 'cperl-mode)

(setq auto-mode-alist
      (cons (cons "\\.t$" 'cperl-mode)
	    auto-mode-alist))
(require 'perl-completion)

;; based on miyagawa's settings
(add-hook 'cperl-mode-hook
          '(lambda ()
	     (progn 
	       (define-key cperl-mode-map "\M-."  'cperl-find-module)
	       (define-key cperl-mode-map "\C-ct" 'perltidy-region)
	       (define-key cperl-mode-map "\C-m"  'newline-and-indent)
	       (setq cperl-auto-newline nil)
	       ;; Use 4 space indents via cperl mode
	       (setq cperl-close-paren-offset -4)
	       (setq cperl-indent-level 4)
	       (setq cperl-label-offset -4)
	       (setq cperl-continued-statement-offset 4)
	       (setq cperl-indent-parens-as-block t)
	       (setq indent-tabs-mode nil)
	       (abbrev-mode t)
	       ;; (setq cperl-invalid-face nil)
	       (setq cperl-electric-keywords nil) ;; ウザい補完をとめる
	       (setq cperl-highlight-variables-indiscriminately t)
	       (ignore-errors
		 (perl-rename-buffer))
	       (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
		 (auto-complete-mode t)
		 (make-variable-buffer-local 'ac-sources)
		 (add-to-list 'ac-sources 'ac-source-perl-completion)
		 (perl-completion-mode t)))))

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

;; -----------------------------------------------------------------------------------------
;; package 名で適当にバッファ名をかえる
;; http://subtech.g.hatena.ne.jp/hirose31/20090624/1245829941
;; -----------------------------------------------------------------------------------------
(defun plcmp-get-current-package-name-first (&optional limitline)
  "nil or string"
  (let ((re (rx-to-string `(and bol
                                (* space)
                                "package"
                                (* space)
                                (group
                                 (regexp ,plcmp-perl-package-re))
                                (* not-newline)
                                ";")))
        (bound (if (not limitline)
                   nil
                 (line-end-position limitline)))
        )
    (save-excursion
      (goto-char (point-min))
      (when (re-search-forward re bound t)
        (match-string-no-properties 1)))))

(defun perl-rename-buffer ()
  (interactive)
  (let ((package-name (plcmp-get-current-package-name-first 16)))
    (when package-name
      (rename-buffer package-name t))))
