;;; ��������С��򱦤�
(set-scroll-bar-mode 'right)

;; ���顼ɽ��
(setq hilit-mode-enable-list  nil
      hilit-background-mode   'light
      ;hilit-background-mode   'dark
      hilit-inhibit-hooks     nil
      hilit-inhibit-rebinding nil)
;; �طʿ������ꤷ�ޤ���
(set-background-color "gray89")
;; ̵�̤ʶ��Ԥ˵��դ��䤹������
(setq-default indicate-empty-lines t)
;; isearch �Υϥ��饤�Ȥ�ȿ����褯����
(setq isearch-lazy-highlight-initial-delay 0)
(require 'hilit19)

(cond
 ;;; Emacs-21 ��ͭ������
 ((>= emacs-major-version 21)
  ;;; ������������Ǥ����ʤ�
  (blink-cursor-mode nil)
  ;;; ��������Ǥϥ�������ɽ���򤷤ʤ�
  (setq cursor-in-non-selected-windows nil)
  ;;; �ե���ȤΥ�������֥�򤷤ʤ�
  (setq scalable-fonts-allowed nil)
  ;;; tool-bar ��ä�
  (tool-bar-mode nil)
  ;;; �Դ֤�����
  (set-default 'line-spacing 1)
  ;; ���߹Ԥ�ϥ��饤��
  (global-hl-line-mode)
  ;; �����ե������ɽ��
  (auto-image-file-mode)
  ;;; �ۥ�����ޥ�����ͭ���ˤ���
  (mouse-wheel-mode)
  ))
