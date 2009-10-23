;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; navi2ch
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)
(setq navi2ch-mona-enable t)
(setq navi2ch-mona-enable-board-list '("mona" "aastory" "kao"))
;; (setq navi2ch-net-http-proxy "127.0.0.1:3128")
;; (setq navi2ch-net-http-proxy nil)

(setq navi2ch-article-max-buffers 15)
(setq navi2ch-article-auto-expunge t)

;; taken from http://navi2ch.sourceforge.net/cgi-bin/wiki/yapw.cgi/Tips?time=1110549201
(defun navi2ch-bookmark-insert-subject (num item)
  (navi2ch-bm-insert-subject
   item num
   (cdr (assq 'subject (navi2ch-bookmark-get-article item)))
   (format "(%4d) [%s]"
	   (my-navi2ch-bookmark-get-article-last-number item)
	   (cdr (assq 'name (navi2ch-bookmark-get-board item))))))

(defun my-navi2ch-bookmark-get-article-last-number (item)
  (let ((file (navi2ch-article-get-file-name
	       (navi2ch-bookmark-get-board item)
	       (navi2ch-bookmark-get-article item)))
	num)
    (save-excursion
      (when (file-exists-p file)
	(with-temp-buffer
	  (navi2ch-insert-file-contents file)
	  (setq num (count-lines (point-min) (point-max))))))
    (or num 0)))

(defadvice navi2ch-bookmark-fetch-article
  (after navi2ch-bookmark-fetch-article-redraw-line activate)
  (let ((item (navi2ch-bookmark-get-property (point)))
	(buffer-read-only nil) num)
    (save-excursion
      (beginning-of-line)
      (looking-at " *\\([0-9]+\\)")
      (setq num (string-to-number (match-string 1)))
      (delete-region (point) (1+ (line-end-position)))
      (navi2ch-bookmark-insert-subject num item))))

;; kill f & b
(define-key navi2ch-article-mode-map "f" nil)
(define-key navi2ch-article-mode-map "b" nil)

(setq navi2ch-mona-enable t)
(setq navi2ch-mona-face-variable 'navi2ch-mona16-face)