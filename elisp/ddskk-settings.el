;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ddskk
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(require 'skk-setup)

;;;;;;;;;; ���Ѥ��뼭������� ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; SKK-JISYO.L ��������ɤ߹�������Ѥ�����
;;(setq skk-large-jisyo "/usr/local/share/skk/SKK-JISYO.L")
;;(setq load-path
;;      (append '("/usr/share/emacs/site-lisp/skk")
;;	      load-path))
; (setq skk-aux-large-jisyo "/usr/share/skk/SKK-JISYO.L")
(setq skk-server-portnum 1178)
(setq skk-server-host "localhost")
;;(setq skk-server-prog "/usr/libexec/skkserv")

;; �������� ���� �ˤ���
;;(setq skk-kutouten-type 'en)

(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
(autoload 'skk-mode "skk" nil t)
(autoload 'skk-auto-fill-mode "skk" nil t)
(autoload 'skk-isearch-mode-setup "skk-isearch" nil t)
(autoload 'skk-isearch-mode-cleanup "skk-isearch" nil t)

;; Enter �����򲡤����Ȥ��ˤϳ��ꤹ��
(setq skk-egg-like-newline t)
;; �������� ���� ��Ȥ�
;;(setq skk-kutouten-type 'en)
;; ���겾̾����̩�������������ͥ�褷��ɽ������
(setq skk-henkan-strict-okuri-precedence t)
;; ������Ͽ�ΤȤ���;�פ����겾̾������ʤ��褦�ˤ���
(setq skk-check-okurigana-on-touroku 'auto)
;; look ���ޥ�ɤ�Ȥä������򤹤�(��������)
(setq skk-use-look t)
;; migemo ��Ȥ����� skk-isearch �ˤϤ��Ȥʤ������Ƥ����ߤ���
(setq skk-isearch-start-mode 'latin)
;; ʣ���� Emacsen ��ư���ƸĿͼ����ͭ����
(setq skk-share-private-jisyo t)

;; ���դΥե����ޥå�
;;; �����ɽ��
(setq skk-date-ad t)
;;; Ⱦ�ѿ���
(setq skk-number-style nil)
