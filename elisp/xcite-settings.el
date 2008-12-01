;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; xcite.el の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'xcite "xcite" "Exciting cite" t)
(autoload 'xcite-yank-cur-msg "xcite" "Exciting cite" t)
(global-set-key "\C-c\C-x" 'xcite)
(global-set-key "\C-c\C-y" 'xcite-yank-cur-msg)
; Wanderlust 2.7 or later 用の設定
(autoload 'xcite-indent-citation "xcite")
(setq wl-draft-cite-function 'xcite-indent-citation)
;; 自分をどう呼んで欲しいの？
(setq wl-draft-config-alist
      '((t
	 ("X-cite-me" . "松"))))
