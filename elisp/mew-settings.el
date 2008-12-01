;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mew
;;   �᡼��꡼���� Mew
;;   M-x mew �ǵ�ư���ޤ�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �ʲ��ϴ���Ū����������Ǥ���
;; �᡼�륢�ɥ쥹��������ϡ�~/.mew.el �˽񤤤Ƥ���������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

;;; ��������Υǥ��쥯�ȥ�
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

;; mew-w3m ��Ȥ�
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
