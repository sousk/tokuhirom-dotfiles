;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sdic の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
(global-set-key "\C-cw" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "カーソル位置の英単語の意味を調べる" t nil)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)



;; これは、動作と見掛けを調節するための設定です。
(setq sdic-window-height 10
      sdic-disable-select-window t)



;; Debian 用パッケージを利用するか、Makefile を利用して辞書を同時にイ
;; ンストールした場合は、辞書に関する設定も完了済ですから、特別な設定
;; は要りません。以下の設定では、個人的に検索する辞書を付け加えていま
;; す。研究室と自宅とで検索する辞書を変更しています。

(if (string-match "^\\(toba\\.\\|toba$\\)" (system-name))
    (setq sdic-eiwa-dictionary-list
	  '((sdicf-client "/usr/local/share/dict/gene.sdic"))
	  sdic-waei-dictionary-list
	  '((sdicf-client "/usr/local/share/dict/edict.sdic"
			  (add-keys-to-headword t)))))
