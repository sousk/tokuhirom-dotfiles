;;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; MATSUNO Tokuhiro.

(setq load-path
      (append '("~/.emacs.d/elisp"
		"~/.emacs.d/elisp/navi2ch/"
		"~/.emacs.d/elisp/howm/"
		"~/.emacs.d/elisp/ddskk/"
		"~/.emacs.d/elisp/apel/"
		"/usr/local/share/emacs/site-lisp/"
		"/usr/share/emacs/site-lisp/howm/"
		"/usr/share/emacs/site-lisp/w3m/"
		)
	      load-path))

(load "config-loader")

(my-run-directories "~/.emacs.d/conf")
(my-run-directories "~/.emacs.d/secret") ;; contains password, etc.

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(howm-menu-todo-num 20))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(server-start)
