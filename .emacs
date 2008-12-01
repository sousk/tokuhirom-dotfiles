;;; -*- Mode: Emacs-Lisp ; Coding: euc-japan -*-
;; MATSUNO Tokuhiro
;; Time-stamp: <2005-09-15 23:40:02 tokuhirom>

;;; マクロサーチパスの追加
(setq load-path
      (append '("~/elisp"
		"/usr/local/share/emacs/site-lisp/"
		"/usr/share/emacs/site-lisp/howm/" "/usr/share/emacs/site-lisp/w3m/"
		"/usr/share/emacs/site-lisp/w3m/shimbun/")
	      load-path))

;; 一般的な設定
(load "zatta-settings")

;;; X な時の設定
(if (eq window-system 'x)
    (load "x-settings.el")
  )

;;*************************************************************
;; アプリケーション的なelisp の設定
;;************************************************************

(load "w3m-settings")
;(load "rd-mode")
(load "navi2ch-settings")
(load "ddskk-settings")
;(load "mew-settings")
;(load "wl-settings")
;(load "yatex-settings")
(load "migemo-settings")
; (load "sdic-settings")
; (load "howm-settings")
(load "mule-ucs-settings")
(load "emacs-wget-settings")
(load "xcite-settings")
(load "cperl-settings")

(require 'elscreen)
(require 'elscreen-tab)
;(require 'elscreen-wl)
(require 'uniquify)

;; 括弧を薄くする
(load "usui-paren")
;; 前のウィンドウへ、次のウィンドウへ、の移動が楽になる
(load "other-window")

;; auto-save-buffers
;; http://namazu.org/~satoru/misc/auto-save/
(progn
  (require 'auto-save-buffers)
  (run-with-idle-timer 0.5 t 'auto-save-buffers))

;; 強調表示付き動的略称展開
;; http://www.namazu.org/~tsuchiya/elisp/#dabbrev-highlight
(require 'dabbrev-highlight)

;; ChangeLog メモ
(progn
  (autoload 'clmemo "clmemo" "ChangeLog memo mode." t)
  (define-key ctl-x-map "M" 'clmemo))  ; お好みのキーバインドを。

;; occur や grep で別ウィンドウに該当行を表示
;; http://www.bookshelf.jp/soft/meadow_47.html#SEC675
(progn
  (require 'fm)
  (add-hook 'occur-mode-hook 'fm-start)
  (add-hook 'compilation-mode-hook 'fm-start))

;; (autoload 'riece "riece" "Start Riece" t)

;; 日本語 info が文字化けしないように
(auto-compression-mode t)

(progn
  (set-input-method "japanese-skk")
  (toggle-input-method nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C プログラムの書式は k&r style
(progn
  (defun my-c-mode-common-hook ()
    (c-set-style "k&r"))
  (add-hook 'c-mode-common-hook 'my-c-mode-common-hook))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; いろいろ
;; Deleteキーでカーソル位置の文字が消えるようにする

(defun memo ()
  (interactive)
    (add-change-log-entry
     nil
     (expand-file-name "~/ChangeLog")))
(define-key ctl-x-map "M" 'memo)

(add-to-list 'auto-mode-alist '("\\.rd$" . rd-mode)) ; メモは rd-mode に

;; 日本語まじってる場合でも ispell が効くように
(eval-after-load "ispell"
 '(setq ispell-skip-region-alist (cons '("[^\000-\377]+")
					ispell-skip-region-alist)))
(eval-after-load "ispell"
  '(setq ispell-skip-region-alist (cons '("[^A-Za-z0-9 -]+")
                                        ispell-skip-region-alist)))

;; pcl-cvs の設定
(autoload 'diff-mode "diff-mode" "Diff major mode" t)
(add-to-list 'auto-mode-alist '("\\.\\(diffs?\\|patch\\|rej\\)\\'" . diff-mode))

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)
