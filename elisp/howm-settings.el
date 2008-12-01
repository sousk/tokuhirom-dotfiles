;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; howm settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'howm-mode)
(global-set-key "\C-c,," 'howm-menu)
(setq howm-menu-lang 'ja)

;; ��������������
(define-key howm-mode-map "\C-c\C-c"
  '(lambda ()
    (interactive)
    (if (y-or-n-p "upload diary ")
	(shell-command
	 (concat "~/batch2.sh &")))))
;; (define-key howm-mode-map "\C-c\C-c"
;;   '(lambda ()
;;     (interactive)
;;     (if (y-or-n-p "upload diary ")
;; 	(shell-command
;; 	 (concat "ruby ~/rb/komono/diary2.rb " buffer-file-name)))))

;; ���ܺ�����������������
(setq howm-template "")

(setq howm-directory "~/memo/")
(setq howm-file-name-format "%Y%m/%Y-%m-%d-%H%M%S.txt")
;;(setq howm-file-name-format "zakkan/%Y%m%d.txt") ; 2004/08/200408210354.howm �ߤ����ʴ����ǡ�
(setq howm-keyword-case-fold-search t) ; <<< ����ʸ����ʸ������̤��ʤ�
(setq howm-list-recent-title t) ; �ֺǶ�Υ��װ������˥����ȥ�ɽ��
(setq howm-list-all-title t) ; �����������˥����ȥ�ɽ��
(setq howm-menu-refresh-after-save nil) ; save ���˥�˥塼��ư��������
(setq howm-refresh-after-save nil) ; save ���˲��������ľ���ʤ�
(setq howm-menu-expiry-hours 2) ; ��˥塼�� 2 ���֥���å���
(add-to-list 'auto-mode-alist '("\\.howm$" . outline-mode)) ; ���� rd-mode ��
(setq dired-bind-jump nil)
(setq howm-view-use-grep t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ����������ץȤΰ���
(setq tdiary-howm-rb "tdiary_howm.rb")
;; ������ URL
(setq tdiary-howm-url "http://tokuhirom.tdiary.net/")

;; update.rb ��̾��
(setq tdiary-howm-updaterb-name "update.rb")
(setq tdiary-howm-userid "tokuhirom")

;; ping ����������ץȤΰ���
(setq tdiary-howm-ping-rb "tdiary_howm_ping.rb")
;; ������̾��(ping server ������)
(setq tdiary-howm-diary-name "TokuLog!")
;; rdf �ե������̾��(ping server ������)
(setq tdiary-howm-rdf-name "index.rdf")
;; ping server �Υꥹ��
(setq tdiary-howm-ping-url-list
      '("http://www.blogpeople.net/servlet/weblogUpdates" ;; BlogPeople
	"http://ping.cocolog-nifty.com/xmlrpc" ;; cocolog ping server
	"http://ping.bloggers.jp/rpc/" ;; ping.bloggers.jp
	"http://bulkfeeds.net/rpc" ;; bulkfeeds
	"http://blog.goo.ne.jp/XMLRPC" ;; goo blog
	"http://ping.blo.gs/" ;; blo.gs
	"http://rpc.blogrolling.com/pinger/" ;; blogrolling
	"http://rpc.technorati.com/rpc/ping" ;; technorati
	;; �ʲ������
	"http://ping.myblog.jp/" ;; MyblogJapan
	"http://rpc.weblogs.com/" ;; Weblogs.com
	))

(defun tdiary-howm-update-diary()
  (interactive)
  (if (y-or-n-p "upload diary ")
      (progn
	(let (passwd)
	  (setq passwd (read-string "passwd : "))
	  ;; update.rb
	  (shell-command
	   (format "%s '%s' '%s' '%s' '%s' '%s' %s"
		   tdiary-howm-rb tdiary-howm-url
		   tdiary-howm-updaterb-name tdiary-howm-userid
		     passwd buffer-file-name "&"))))))

;; ��������������
(define-key howm-mode-map "\C-c\C-c" 'tdiary-howm-update-diary)

(defun tdiary-howm-send-ping()
  (interactive)
  (if (y-or-n-p "send ping ")
      (let ((list tdiary-howm-ping-url-list) element (commandline ""))
	(while list
	  (setq element (car list))
	  ;; send ping
	  (setq commandline
		(format "%s %s '%s' '%s' '%s';"
			commandline
			tdiary-howm-ping-rb tdiary-howm-diary-name
			tdiary-howm-url element))
	  (setq list (cdr list)))
	(shell-command commandline))))


