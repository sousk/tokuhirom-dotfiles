;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ddskk
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; SKK-JISYO.L をメモリ上に読み込んで利用する場合
;;(setq skk-large-jisyo "/usr/local/share/skk/SKK-JISYO.L")
;;(setq load-path
;;      (append '("/usr/share/emacs/site-lisp/skk")
;;	      load-path))
; (setq skk-aux-large-jisyo "/usr/share/skk/SKK-JISYO.L")
(setq skk-server-portnum 1178)
(setq skk-server-host "localhost")
;;(setq skk-server-prog "/usr/libexec/skkserv")

;; 句読点を ，． にする
;;(setq skk-kutouten-type 'en)

(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
(autoload 'skk-mode "skk" nil t)
(autoload 'skk-auto-fill-mode "skk" nil t)
(autoload 'skk-isearch-mode-setup "skk-isearch" nil t)
(autoload 'skk-isearch-mode-cleanup "skk-isearch" nil t)

;; Enter キーを押したときには確定する
(setq skk-egg-like-newline t)
;; 句読点に ．， を使う
;;(setq skk-kutouten-type 'en)
;; 送り仮名が厳密に正しい候補を優先して表示する
(setq skk-henkan-strict-okuri-precedence t)
;; 辞書登録のとき、余計な送り仮名を送らないようにする
(setq skk-check-okurigana-on-touroku 'auto)
;; look コマンドを使った検索をする(これ便利)
(setq skk-use-look t)
;; migemo を使うから skk-isearch にはおとなしくしていて欲しい
(setq skk-isearch-start-mode 'latin)
;; 複数の Emacsen を起動して個人辞書を共有する
(setq skk-share-private-jisyo t)
;;; 西暦で表示
(setq skk-date-ad t)
;;; 半角数字
(setq skk-number-style nil)

