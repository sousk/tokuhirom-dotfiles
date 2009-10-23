;; -*- emacs-lisp -*-
;; ��̤ο�����������

;; ����� () �ο������
(defvar paren-face 'paren-face)
(make-face 'paren-face)
(set-face-foreground 'paren-face "#88aaff")

;; ���� {} �ο������
(defvar brace-face 'brace-face)
(make-face 'brace-face)
(set-face-foreground 'brace-face "#ffaa88")

;; ���� [] �ο������
(defvar bracket-face 'bracket-face)
(make-face 'bracket-face)
(set-face-foreground 'bracket-face "#aaaa00")

;; lisp-mode �ο�������ɲ�
(setq lisp-font-lock-keywords-2
      (append '(("(\\|)" . paren-face))
	      lisp-font-lock-keywords-2))

;; scheme-mode �ο�������ɲ�
(add-hook 'scheme-mode-hook
	  '(lambda ()
	     (setq scheme-font-lock-keywords-2
		   (append '(("(\\|)" . paren-face))
			   scheme-font-lock-keywords-2))))

;; c-mode �ο�������ɲ�
(setq c-font-lock-keywords-3
      (append '(("(\\|)" . paren-face))
	      '(("{\\|}" . brace-face))
	      '(("\\[\\|\\]" . bracket-face))
	      c-font-lock-keywords-3))
