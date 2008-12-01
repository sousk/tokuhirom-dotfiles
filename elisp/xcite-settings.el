;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; xcite.el ������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'xcite "xcite" "Exciting cite" t)
(autoload 'xcite-yank-cur-msg "xcite" "Exciting cite" t)
(global-set-key "\C-c\C-x" 'xcite)
(global-set-key "\C-c\C-y" 'xcite-yank-cur-msg)
; Wanderlust 2.7 or later �Ѥ�����
(autoload 'xcite-indent-citation "xcite")
(setq wl-draft-cite-function 'xcite-indent-citation)
;; ��ʬ��ɤ��Ƥ���ߤ����Ρ�
(setq wl-draft-config-alist
      '((t
	 ("X-cite-me" . "��"))))
