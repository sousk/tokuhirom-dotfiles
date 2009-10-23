(require 'autoinsert)

;; テンプレートのディレクトリ
(setq auto-insert-directory "~/.emacs.d/share/autoinsert/")

;; 各ファイルによってテンプレートを切り替える
(setq auto-insert-alist
      (nconc '(
               ("\\.cpp$"	.	["template.cpp" my-c-template])
               ("\\.h$"		.	["template.h" my-c-template])
               (cperl-mode lambda ()
                    (when (perl-get-package-string)
                      (perl-insert-package)
                      (insert "\n"))
                    (insert "use strict;\n")
                    (insert "use warnings;\n")
                    (insert "use utf8;\n")
                    ;; insert "1;" end of buf if new buffer is under lib dir and extension is .pm
                    (when (and (perl-get-package-string)
                               (string= "pm" (file-name-extension buffer-file-truename)))
                      (insert "\n\n" "1;" "\n")))
               )))
(require 'cl)

;; ここが腕の見せ所
(defvar my-c-template-replacements-alists
  '(("%file%"             . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%include-guard%"    . (lambda () (format "__SCHEME_%s__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))

(defun my-c-template ()
  (time-stamp)
  (mapc #'(lambda(c)
	    (progn
	      (goto-char (point-min))
	      (replace-string (car c) (funcall (cdr c)) nil)))
	my-c-template-replacements-alists)
  (goto-char (point-max))
  (message "done."))

(defun perl-get-package-string ()
  (interactive)
  (require 'perl-completion)
  (let ((lib-path (plcmp--get-lib-path)))
    (when (and lib-path buffer-file-truename)
      (let* ((s (replace-regexp-in-string
                 (rx-to-string `(and bol ,lib-path (? "/")))
                 ""
                 (expand-file-name buffer-file-truename)))
             (s (file-name-sans-extension (replace-regexp-in-string (rx "/") "::" (replace-regexp-in-string "^.+/lib/" "" s)))))
        s))))
 
 
(defun perl-insert-package ()
  (interactive)
  (let ((s (perl-get-package-string)))
    (when s
      (insert "package " s ";"))))
 
;; my config for autoinsert.el
(setq auto-insert-alist
      '(
        
        ))

;; 最後に hook
(add-hook 'find-file-not-found-hooks 'auto-insert)
