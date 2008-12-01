;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sdic ������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'sdic-describe-word "sdic" "��ñ��ΰ�̣��Ĵ�٤�" t nil)
(global-set-key "\C-cw" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "����������֤α�ñ��ΰ�̣��Ĵ�٤�" t nil)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)



;; ����ϡ�ư��ȸ��ݤ���Ĵ�᤹�뤿�������Ǥ���
(setq sdic-window-height 10
      sdic-disable-select-window t)



;; Debian �ѥѥå����������Ѥ��뤫��Makefile �����Ѥ��Ƽ����Ʊ���˥�
;; �󥹥ȡ��뤷�����ϡ�����˴ؤ�������ⴰλ�ѤǤ����顢���̤�����
;; ���פ�ޤ��󡣰ʲ�������Ǥϡ��Ŀ�Ū�˸������뼭����դ��ä��Ƥ���
;; �������漼�ȼ���ȤǸ������뼭����ѹ����Ƥ��ޤ���

(if (string-match "^\\(toba\\.\\|toba$\\)" (system-name))
    (setq sdic-eiwa-dictionary-list
	  '((sdicf-client "/usr/local/share/dict/gene.sdic"))
	  sdic-waei-dictionary-list
	  '((sdicf-client "/usr/local/share/dict/edict.sdic"
			  (add-keys-to-headword t)))))
