;;; スクロールバーを右に
(set-scroll-bar-mode 'right)

;; カラー表示
(setq hilit-mode-enable-list  nil
      hilit-background-mode   'light
      ;hilit-background-mode   'dark
      hilit-inhibit-hooks     nil
      hilit-inhibit-rebinding nil)
;; 背景色を設定します。
(set-background-color "gray89")
;; 無駄な空行に気付きやすくする
(setq-default indicate-empty-lines t)
;; isearch のハイライトの反応をよくする
(setq isearch-lazy-highlight-initial-delay 0)
(require 'hilit19)

(cond
 ;;; Emacs-21 特有の設定
 ((>= emacs-major-version 21)
  ;;; カーソルを点滅させない
  (blink-cursor-mode nil)
  ;;; 非選択窓ではカーソル表示をしない
  (setq cursor-in-non-selected-windows nil)
  ;;; フォントのスケーラブルをしない
  (setq scalable-fonts-allowed nil)
  ;;; tool-bar を消す
  (tool-bar-mode nil)
  ;;; 行間の設定
  (set-default 'line-spacing 1)
  ;; 現在行をハイライト
  (global-hl-line-mode)
  ;; 画像ファイルを表示
  (auto-image-file-mode)
  ;;; ホイールマウスを有効にする
  (mouse-wheel-mode)
  ))
