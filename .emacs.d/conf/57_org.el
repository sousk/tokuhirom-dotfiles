;; org-mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
; TODO 完了記録をとる
(setq org-log-done t)
; デフォルトはひらいた状態
(setq org-startup-folded "showall")

(define-key org-mode-map "\C-c\C-c"
  (lambda ()
    (interactive)
    (when (and
	   (buffer-file-name))
      (save-buffer)
      (kill-buffer nil))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODOファイルをひらく
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun todo ()
  (interactive)
  (find-file "~/share/howm/todo.org"))
