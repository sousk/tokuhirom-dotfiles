(require 'flymake)
(require 'set-perl5lib)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flymake for perl
;; taken from http://unknownplace.org/memo/2007/12/21#e001

(defvar flymake-perl-err-line-patterns '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))
(defconst flymake-allowed-perl-file-name-masks '(("\\.pl$" flymake-perl-init)
                                               ("\\.pm$" flymake-perl-init)
                                               ("\\.t$" flymake-perl-init)))

(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc" local-file))))

(defun flymake-perl-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
  (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
  (set-perl5lib)
  (flymake-mode t))

(add-hook 'cperl-mode-hook '(lambda () (flymake-perl-load)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for js
;; spidermonkey required.
;; flymake for javascript
(defconst flymake-allowed-js-file-name-masks '(("\\.json$" flymake-js-init)
                                               ("\\.js$" flymake-js-init)))
(defcustom flymake-js-detect-trailing-comma t nil :type 'boolean)
(defvar flymake-js-err-line-patterns '(("^\\(.+\\)\:\\([0-9]+\\)\: \\(SyntaxError\:.+\\)\:$" 1 2 nil 3)))
(when flymake-js-detect-trailing-comma
  (setq flymake-js-err-line-patterns (append flymake-js-err-line-patterns
                                             '(("^\\(.+\\)\:\\([0-9]+\\)\: \\(strict warning: trailing comma.+\\)\:$" 1 2 nil 3)))))

(defun flymake-js-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "js" (list "-s" local-file))))
(defun flymake-js-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-js-file-name-masks))
  (setq flymake-err-line-patterns flymake-js-err-line-patterns)
  (flymake-mode t))

(add-hook 'javascript-mode-hook '(lambda () (flymake-js-load)))
