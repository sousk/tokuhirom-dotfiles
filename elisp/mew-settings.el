;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mew
;;   メールリーダー Mew
;;   M-x mew で起動します
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 以下は基本的な設定だけです．
;; メールアドレス等の設定は，~/.mew.el に書いてください．
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

;;; アイコンのディレクトリ
;;(setq mew-icon-directory "/usr/lib/emacs/etc/Mew")

(if (boundp 'read-mail-command)
    (setq read-mail-command 'mew))
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

;; mew-w3m を使う
(setq mew-mime-multipart-alternative-list
      '(("text/html" "text/plain" ".*")))
(setq mew-w3m-auto-insert-image t)
(setq mew-use-w3m-minor-mode t)
(require 'mew-w3m)
(define-key mew-summary-mode-map "T" 'mew-w3m-view-inline-image)

;; imap
(setq mew-imap-server "localhost")
(setq mew-imap-auth t)
(setq mew-imap-auth-list '("CRAM-MD5"))

(setq mew-imap-auth t)
(setq mew-imap-auth-list '("CRAM-MD5" "LOGIN"))
