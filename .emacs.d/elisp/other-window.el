;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; other-window-backward settings
;; ���Υ�����ɥ��ء����Υ�����ɥ��ء��ΰ�ư���ڤˤʤ�
;; GNU Emacs ��ĥ�����ɤ��
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun other-window-backward (&optional n)
  "Select Nth previous window."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))
(global-set-key "\C-x\C-p" 'other-window-backward)
(global-set-key "\C-x\C-n" 'other-window)

