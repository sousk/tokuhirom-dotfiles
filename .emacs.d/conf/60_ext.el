;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 前のウィンドウへ、次のウィンドウへ、の移動が楽になる
;;  taken from GNU Emacs 拡張ガイド
;;  これは後の方にロードしないと、うわがきされちゃうなり。
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun other-window-backward (&optional n)
  "Select Nth previous window."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))
(global-set-key "\C-x\C-p" 'other-window-backward)
(global-set-key "\C-x\C-n" 'other-window)
