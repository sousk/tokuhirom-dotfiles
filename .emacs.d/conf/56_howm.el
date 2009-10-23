;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; howm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq howm-view-title-header "*") ;; ← howm のロードより前に書くこと
(setq howm-view-title-regexp-grep "^\* +[^2]")
(setq howm-view-title-regexp "^\\*\\( +\\([^2].*\\)\\|\\)$")

(load "howm")

(setq howm-directory "~/share/howm")

;; 完了ずみ todo は表示しない
(setq howm-todo-menu-types "[-+~!]")

;; menu を二時間キャッシュ
;; (setq howm-menu-expiry-hours 2)
(setq howm-menu-expiry-hours nil)

;; いちいち消すのも面倒なので
;; 内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))

;; http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;; C-cC-c で保存してバッファをキルする
(defun my-save-and-kill-buffer ()
  (interactive)
  (when (and
         (buffer-file-name)
         (string-match "\\.howm"
                       (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(eval-after-load "howm"
  '(progn
     (define-key howm-mode-map
       "\C-c\C-c" 'my-save-and-kill-buffer)))

;; M-t で今日の日付で todo 入力。
(defun oreore-howm-insert-todo ()
  (interactive)
  (insert (format-time-string "[%Y-%m-%d]+ ")))
(define-key esc-map
  "t"
  'oreore-howm-insert-todo)

;; org-mode でメモる
(setq howm-template "* %title%cursor\n%date\n")
(add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))

;; menu ファイルの位置をうつす
(setq howm-menu-file "~/.howm-menu")
