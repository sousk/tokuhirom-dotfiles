;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; other-window-backward settings
;; 前のウィンドウへ、次のウィンドウへ、の移動が楽になる
;; GNU Emacs 拡張ガイドより
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun other-window-backward (&optional n)
  "Select Nth previous window."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))
(global-set-key "\C-x\C-p" 'other-window-backward)
(global-set-key "\C-x\C-n" 'other-window)

