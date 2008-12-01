;; -*- emacs-lisp -*-

;; ~/bin に PATH を通す & exec-path に追加
(progn
  (setenv "PATH" (concat "~/bin:" (getenv "PATH")))
  (add-to-list 'exec-path "~/bin"))

;; 日本語の設定(UTF-8)
(progn
  (set-language-environment "Japanese")
  (set-default-coding-systems 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8 . utf-8))
  (if (not window-system) (set-terminal-coding-system 'utf-8))
  (setq file-name-coding-system 'utf-8)
  (setq menu-coding-system 'utf-8))

;; タイムロケールを英語に
(setq system-time-locale "C")

;; 見た目の設定
(progn
  (require 'font-lock)                       ;; 色付ける
  (global-font-lock-mode t)
  (show-paren-mode)                          ;; 対応する括弧をハイライト
  (menu-bar-mode -1)                         ;; メニューバーを消す
  (setq transient-mark-mode t)               ;; 選択領域を色付け
  (line-number-mode t)                       ;; カーソルの位置が何行目かを表示する
  (column-number-mode t)                     ;; カーソルの位置が何桁目かを表示する
  (setq use-dialog-boxes nil)                ;; ダイアログボックスを使わない
  (setq mode-line-frame-identification " ")  ;; フレーム情報を隠す
  (setq visible-bell t)                      ;; visible-bell
  )


;;; 最下行で「↓」を押したときスムーズなスクロールにする
(progn
 (setq scroll-step 1)
 (setq scroll-conservatively 4))

;;; PageUp,PageDown の時にカーソル位置を保持
(setq scroll-preserve-screen-position t)

;;; マウスの真ん中ボタンでペーストする時にカーソル位置を変更しない
(setq mouse-yank-at-point t)

;;; カーソルが行頭にあるときに，C-k 1回で その行全体を削除
(setq kill-whole-line t)

;;; yes,no を答えるかわりに，y,n にする
(fset 'yes-or-no-p 'y-or-n-p)

(progn
                                        ; .save.. というファイルを作らない
  (setq auto-save-list-file-name nil)
  (setq auto-save-list-file-prefix nil)
                                        ; ~ つきのバックアップファイルを作らない
  (setq make-backup-files nil))

;;; 起動直後の *scratch* buffer に入る文字列をなくす
(setq initial-scratch-message nil)

;;; startup message を消す
(setq inhibit-startup-message t)

;;; gzipされた info を見る
(auto-compression-mode t)

;;; shell-mode で ^M を出さなくする．
(add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)

;;; ステータスラインに時間を表示する
(progn
  (setq display-time-24hr-format t)
  (setq display-time-format "%Y-%m-%d(%a) %H:%M")
  (setq display-time-day-and-date t)
  (setq display-time-interval 30)
  (display-time))

;;; emacsclient サーバを起動
(server-start)

;; 常にホームディレクトリから
;; (cd "~")

;;; 80 桁にあわせる
(progn
  (setq-default fill-column 80)
  (setq text-mode-hook 'turn-on-auto-fill)
  (setq default-major-mode 'text-mode)
  (auto-fill-mode))

;; .h なファイルは C++-mode で．
(setq auto-mode-alist
      (cons (cons "\\.h$" 'c++-mode)
	    auto-mode-alist))

;;; key config
(progn
  (global-set-key "\M-?" 'help-for-help)
  (global-set-key "\M-g" 'goto-line)
  (global-set-key "\C-h" 'backward-delete-char)
  (global-set-key [delete] 'delete-char))

;; Emacs 21以降だと Makefile の編集時にTABを打ったときに "Suspicious
;; line XXX.  Save anyway?" というプロンプトが出るのでこれを抑制する
(add-hook 'makefile-mode-hook
	  (function
	   (lambda () (fset 'makefile-warn-suspicious-lines 'ignore))))

;; gauche の設定
;; (progn
;;   (setq quack-default-program "gosh")
;;   (setq scheme-program-name "gosh")
;;   (autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process. " t)
;;   (require 'inferior-gauche)
;;   (setq auto-mode-alist
;; 	(cons '("\\.scm$" . inferior-gauche-mode) auto-mode-alist))
;;   (setq default-major-mode 'inferior-gauche-mode)
;;   (inferior-gauche-mode))


;; eldoc
;; http://www.bookshelf.jp/soft/meadow_41.html#SEC598
(autoload 'turn-on-eldoc-mode "eldoc" nil t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(setq tab-width 4)

;; html-tt(by clouder)
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist
      (cons
       '("\\.html$" . html-helper-mode) auto-mode-alist))
(require 'html-tt)
(add-hook 'html-helper-mode-hook 'html-tt-load-hook)

;; .svn は補完対象から外す
(add-to-list 'completion-ignored-extensions ".svn/")
;; 補完は ignore-case で。
(setq completion-ignore-case t)

;; psvn を有効に
(autoload 'svn-status "psvn" nil t)


(abbrev-mode 1)

(define-abbrev-table 'global-abbrev-table
  '(
    ("lcom"   "# =========================================================================" nil 1)
    ("com"   "# -------------------------------------------------------------------------" nil 1)
    ))


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
