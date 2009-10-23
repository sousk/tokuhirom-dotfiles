;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; migemo.el の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Emacs 側でのキャッシュを有効にする
(load "migemo.el")
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
;; (setq migemo-user-dictionary nil)
;; (setq migemo-regex-dictionary nil)
;; (setq migemo-options '("-q" "--emacs" "-i" "\a"))
;; (setq migemo-user-dictionary (expand-file-name "~/share/migemo-dict"))
