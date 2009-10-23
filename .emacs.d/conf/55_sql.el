;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sql-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'sql-mode-hook
	  (lambda ()
	    ;; mysql つかうあるよ
	    (setq sql-product 'mysql)
	    ;; ユーザ設定とか
	    (setq sql-user "root")
	    ;; インデントの設定とか
	    (load-library "sql-indent")
	    (setq sql-indent-offset 4)
	    (setq sql-indent-maybe-tab nil)
	    ;; ちょっとダサいけど…… LIMIT を追加しただけ……
	    (setq sql-indent-first-column-regexp
		  (concat "^\\s-*"
			  (regexp-opt
			   '(
			     "select" "update" "insert" "delete"
			     "union" "intersect"
			     "from" "where" "into" "group" "having" "order"
			     "set" "and" "or" "exists" "limit"
			     "--") t) "\\(\\b\\|\\s-\\)"))))
