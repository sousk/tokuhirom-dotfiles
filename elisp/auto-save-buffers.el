;;
;;

;; auto-save-buffers ���оݤȤ���ե����������ɽ��
(defvar auto-save-buffers-regexp ""
  "*Regexp that matches `buffer-file-name' to be auto-saved.")

(defun auto-save-buffers ()
  "Save buffers if `buffer-file-name' matches `auto-save-buffers-regexp'."
  (let ((buffers (buffer-list))
	buffer)
    (save-excursion
      (while buffers
	(set-buffer (car buffers))
	(if (and buffer-file-name
		 (buffer-modified-p)
		 (not buffer-read-only)
		 (string-match auto-save-buffers-regexp buffer-file-name)
		 (file-writable-p buffer-file-name))
	    (save-buffer))
	(setq buffers (cdr buffers))))))

(provide 'auto-save-buffers)

