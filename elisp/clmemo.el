;;; clmemo.el --- Change Log MEMO -*-emacs-lisp-*-

;; Copyright (c) 2002, 2003 Masayuki Ataka <ataka@milk.freemail.ne.jp>
;; $Id: clmemo.el,v 1.1 2005/09/16 03:53:25 tokuhiro Exp $

;; Author: Masayuki Ataka <ataka@milk.freemail.ne.jp>
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, you can either send email to this
;; program's maintainer or write to: The Free Software Foundation,
;; Inc.; 59 Temple Place, Suite 330; Boston, MA 02111-1307, USA.

;;; Commentary:

;; clmemo is minor mode for editing ChangeLog MEMO.

;; ChangeLog memo is a kind of a diary and a memo file.  For more
;; information, see web page <http://namazu.org/~satoru/unimag/1/>.
;; `M-x clmemo' open ChangeLog memo file directly in ChangeLog MEMO
;; mode.  Select your favorite entry with completion.  For a complition
;; list, use `clmemo-entry-list'.

;; The latest clmemo.el is available at:
;;
;;   http://isweb22.infoseek.co.jp/computer/pop-club/emacs/clmemo.el

;; Special thanks to rubikitch for clmemo-yank, clmemo-indent-region,
;; and bug fix of quitting entry.  Great thanks to Tetsuya Irie, Souhei
;; Kawazu, Katsuwo Mogi, Hideaki Shirai, and ELF ML members for all
;; their help.

;;; How to install:

;; To install, put this in your .emacs file:
;;
;;   (autoload 'clmemo "clmemo" "ChangeLog memo mode." t)

;; And set your favorite key-binding and entries of MEMO.  For example:
;;
;;   (define-key ctl-x-map "M" 'clmemo)
;;   (setq clmemo-entry-list
;;        '("Emacs" "StarWars" '("lotr" . "The Load of the Rings") etc...))

;; Put this in the bottom of your ChangeLog MEMO file.
;;
;;   ^L
;;   ;;; Local Variables: ***
;;   ;;; mode: change-log ***
;;   ;;; clmemo-mode: t ***
;;   ;;; End: ***
;;
;; This code tells Emacs to set major mode change-log and toggle minor
;; mode clmemo-mode ON in your ChangeLog MEMO.  For more information,
;; see section "File Variables" in `GNU Emacs Reference Manual'.
;;
;; `^L' is a page delimiter.  You can insert it with C-q C-l.
;;
;; If you are Japanese, it is good idea to specify file coding system
;; like this;
;;
;;   ^L
;;   ;;; Local Variables: ***
;;   ;;; mode: change-log ***
;;   ;;; clmemo-mode: t ***
;;   ;;; coding: iso-2022-jp ***
;;   ;;; End: ***
;;


;;; Code:
(provide 'clmemo)
(require 'add-log)

(autoload 'clgrep "clgrep" "grep mode for ChangeLog file." t)
(autoload 'clgrep-title "clgrep" "grep first line of entry in ChangeLog." t)
(autoload 'clgrep-header "clgrep" "grep header line of ChangeLog." t)
(autoload 'clgrep-clmemo "clgrep" "clgrep directly ChangeLog MEMO." t)

;;
;; User Options
;;
(defvar clmemo-entry-upper-case nil
  "*If nil, case insensitive for entry text.
If t, capitalize the whole entry text.
If 1, capitalize initial letter.")

(defvar clmemo-file-name "~/clmemo.txt"
  "*Clmemo file name.")

(defvar clmemo-entry-list
  '("idea" "system" "url")
  "*List of entries.
Set your favourite entry of ChangeLog MEMO.

It is possible to mix strings and cons-cells.
For example:
(setq clmemo-entry-list
  (\"url\" (\"clmemo\" . \"ChangeLog MEMO\")))
Cars are dummy and cdrs are the true entry.
This case, clmemo is a dummy entry of ChangeLog MEMO.")

(defvar clmemo-subentry-char "+"
  "*If this char is in the end of entry, ask subentry.")

(defvar clmemo-subentry-punctuation-char '(" (" . ")")
  "*Car is left string of subentry punctuation char; Cdr is right.")

(defvar clmemo-schedule-header "[s]"
  "Header string for schedule.")

(defvar clmemo-time-string-with-weekday nil
  "*If non-nil, append weekday after date.")

(defvar clmemo-indent-only-one-tab nil
  "*If non-nil, `clmemo-indent-region' indent with only one tab.")

;;
;; System Variables
;;

(defvar clmemo-header-regexp "^\\<")
(defvar clmemo-memo-separate "[ \t\n]+\n\t\\* ")
(defvar clmemo-dummy-entry "\n\t* DUMMY: \n")
(defvar clmemo-new-entry 'add-change-log-entry-other-window)
(defvar clmemo-call-clgrep 'clgrep-clmemo)
(defvar clmemo-replace-entry "^\t\\* \\(.+\\):")
(defvar clmemo-minor-mode 'clmemo-mode)
(defvar clmemo-winconf nil)

(defvar clmemo-font-lock-keywords
  '("^\\sw.........[0-9:+ ]*\\((...)\\)?"
    (0 'change-log-date-face)
    ("\\([^<(]+?\\)[ \t]*[(<]\\([A-Za-z0-9_.-]+@[A-Za-z0-9_.-]+\\)[>)]" nil nil
     (1 'change-log-name-face)
     (2 'change-log-email-face)))
  "Additional expressions to highlight in ChangeLog Memo mode.")

(setq change-log-font-lock-keywords
      (cons clmemo-font-lock-keywords change-log-font-lock-keywords))

;;;###autoload
(defvar clmemo-mode nil
  "Toggle clmemo-mode.")
(make-variable-buffer-local 'clmemo-mode)

(unless (assq 'clmemo-mode minor-mode-alist)
  (setq minor-mode-alist
	(cons '(clmemo-mode " MEMO") minor-mode-alist)))

;;;###autoload
(defun clmemo (arg)
  "Open ChangeLog memo file and ask entry.

With prefix argument ARG, just open ChangeLog memo file.
 If already visited the ChangeLog memo file,
 ask entry and insert it in the date where point is
Prefix argument twice (C-u C-u), then call `clgrep-clmemo'.
Three times (C-u C-u C-u), then `clgrep-clmemo' in reverse order.
C-u 0, toggle open other window and call `clgrep-clmemo'.
C-u 1, toggle open other window and call `clgrep-clmemo' in reverse order.

For ChangeLog memo file, use var `clmemo-file-name'.
See also `add-change-log-entry' and `clmemo-get-entry'."
  (interactive "P")
  (setq clmemo-winconf (current-window-configuration))
  (let ((add-log-time-format (if clmemo-time-string-with-weekday
				 'add-log-iso8601-time-string-with-weekday
			       'add-log-iso8601-time-string))
	(file (expand-file-name clmemo-file-name)))
    (cond
     ;; With no prefix argument.
     ((not arg)
      (let ((buf-orig (current-buffer))
	    (entry    (clmemo-get-entry)))
	(funcall clmemo-new-entry nil file)
	(funcall clmemo-minor-mode)
	(clmemo-insert-entry buf-orig entry)))
     ;; C-u C-u C-u
     ((equal arg '(64))
      (funcall clmemo-call-clgrep))
     ;; C-u C-u
     ((equal arg '(16))
      (setq current-prefix-arg nil)
      (funcall clmemo-call-clgrep))
     ;; C-u 0  -- Toggle other window
     ((equal arg 0)
      (funcall clmemo-call-clgrep))
     ;; C-u 1  -- Toggle other window in reverse order.
     ((equal arg 1)
      (funcall clmemo-call-clgrep))
     ;; C-u
     (arg
      (if (equal buffer-file-name file)
	  (let ((buf-org (current-buffer))
		(entry   (clmemo-get-entry)))
	    (re-search-backward clmemo-header-regexp nil t)
	    (forward-line 1)
	    (insert clmemo-dummy-entry)
	    (backward-char 1)
	    (clmemo-insert-entry buf-org entry))
	(if (get-file-buffer file)
	    (switch-to-buffer (get-file-buffer file))
	  (switch-to-buffer (find-file-noselect file))))))))

(defun clmemo-mode (&optional arg)
  "Minor mode to insert entry with completion for ChangeLog MEMO.
For more information, See function `clmemo'.

\\{clmemo-mode-map}
"
  (interactive "P")
  (if (< (prefix-numeric-value arg) 0)
      (setq clmemo-mode nil)
    (setq clmemo-mode t)))

(defun clmemo-get-entry ()
  "Ask entry of ChangeLog MEMO and return string of entry.

If the last char of the entry is `clmemo-subentry-char',
also ask the subentry.

If `clmemo-entry-upper-case' is t, capitalize whole entry.
If 1, capitalize initial letter of entry.
If nil, do nothing."
  (let ((entry (clmemo-completing-read "clmemo entry: ")))
    (when (and (not (string= "" entry))
	       (clmemo-subentry-p entry))
      (let* ((main  (substring entry 0 (- (length clmemo-subentry-char))))
	     (sub   (clmemo-completing-read (format "subentry for %s: " main)))
	     (left  (car clmemo-subentry-punctuation-char))
	     (right (cdr clmemo-subentry-punctuation-char)))
	(setq entry (concat main left sub right))))
    entry))

(defun clmemo-insert-entry (buf-orig entry)
  "Insert ChangeLog memo entry."
  (save-excursion
    (let ((eol (progn (end-of-line 1) (point))))
      (unless (string= "" entry)
	(forward-line 0)
	(if (looking-at clmemo-replace-entry)
	    (replace-match entry t nil nil 1)
	  (end-of-line 1)
	  (insert entry ": ")))
      (beginning-of-line 1)
      (if (search-forward "DUMMY: " nil t)
	  (replace-match ""))))
  (end-of-line 1)
  (when (fboundp 'clkwd-insert-url)
    (clkwd-insert-url (clkwd-assoc-format 'clkwd-insert-url 
					  clkwd-insert-function-alist)
		      buf-orig t)))


(defun clmemo-completing-read (prompt)
  "Read a string in the minibuffer, with completion using `clmemo-entry-list'.

PROMPT is a string to prompt with; normally it ends in a colon and space."
  (let* ((completion-ignore-case t)
	 (alist (mapcar (lambda (x) (if (consp x) x (cons x x)))
			clmemo-entry-list))
	 (item  (completing-read prompt alist))
	 (subp  (and (not (string= item "")) (clmemo-subentry-p item)))
	 (cell  (if subp
		    (assoc (substring item 0 (- (length clmemo-subentry-char))) alist)
		  (assoc item alist)))
	 (entry (or (cdr cell)
		    (if subp
			(substring item 0 (- (length clmemo-subentry-char)))
		      item))))
    ;; Change case of entry.
    (setq entry 
	  (cond
	   ;; Capitalize whole entry text.
	   ((equal clmemo-entry-upper-case t)
	    (upcase entry))
	   ;; Capitalize initial letter of the entry.
	   ((equal clmemo-entry-upper-case 1)
	    (capitalize entry))
	   ;; As it is.
	   (t entry)))
    ;; Add subentry suffix if needed.
    (if subp
	(concat entry clmemo-subentry-char)
      entry)))
  

(defun clmemo-subentry-p (entry)
  "Return t if argument ENTRY has subentry suffix.
Subentry suffix is defined in variable `clmemo-subentry-char'."
  (and clmemo-subentry-char
       (string= clmemo-subentry-char
		(substring entry (- (length clmemo-subentry-char))))))



;;
;; Header with or without weekday 
;;

;; Code contributed by Satoru Takabayashi <satoru@namazu.org>
(defun add-log-iso8601-time-string-with-weekday ()
  (let ((system-time-locale "C"))
    (concat (add-log-iso8601-time-string)
            " " "(" (format-time-string "%a") ")")))


(defun clmemo-format-header-with-weekday (beg end)
  "Format ChangeLog header with weekday
FROM: 2001-01-01  ataka
TO:   2001-01-01 (Mon)  ataka

See also function `clmemo-format-header-without-weekday'."
  (interactive "r")
  (let* ((system-time-locale "C")
	 date weekday)
    (save-excursion
      (goto-char beg)
      (while (re-search-forward "^\\([-0-9]+\\)" end t)
	(save-match-data
	  (setq date    (match-string 0)
		weekday (format-time-string "%a" (date-to-time (concat date " 0:0:0")))))
	(replace-match (concat date " (" weekday ")"))))))

(defun clmemo-format-header-without-weekday (beg end)
  "Format ChangeLog header without weekday
FROM:   2001-01-01 (Mon)  ataka
TO:     2001-01-01  ataka

See also function `clmemo-format-header-with-weekday'."
  (interactive "r")
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "^\\([-0-9]+\\) (.+)" end t)
      (replace-match "\\1"))))



;;
;; ChangeLog MEMO Mode
;;

(defvar clmemo-mode-map nil)
(if clmemo-mode-map
    nil
  (let ((map (make-keymap)))
    ;; clgrep
    ;; Movement
    (define-key map "\C-c\C-f" 'forward-paragraph)
    (define-key map "\C-c\C-b" 'backward-paragraph)
    (define-key map "\C-c\C-n" 'forward-page)
    (define-key map "\C-c\C-p" 'backward-page)
    ;; yank and indent
    (define-key map "\C-c\C-y" 'clmemo-yank)
    (define-key map "\C-c\C-i" 'clmemo-indent-region)
    ;; Schedule
    (define-key map "\C-c\C-c" 'clmemo-schedule)
    ;; Exit
    (define-key map "\C-c\C-q" 'clmemo-exit)
    (setq clmemo-mode-map map)))

(eval-after-load 'clgrep
  '(progn
     (define-key clmemo-mode-map "\C-c\C-f" 'clgrep-forward-entry)
     (define-key clmemo-mode-map "\C-c\C-b" 'clgrep-backward-entry)))

(unless (assq 'clmemo-mode minor-mode-map-alist)
  (setq minor-mode-map-alist
	(cons (cons 'clmemo-mode clmemo-mode-map) minor-mode-map-alist)))


(defun clmemo-yank (&optional arg)
  "Yank with indent.

With prefix argument, Point returns the point where start yank.
Do not indent when `yank-pop'."
  (interactive "P")
  (unless (bolp)
    (backward-char 1)
    (if (looking-at "^\t")
	(delete-char 1)
      (forward-char 1)))
  (let ((beg (point))
        (end (progn (yank) (point))))
    (clmemo-indent-region beg end)
    (when arg
      (goto-char beg))))

(defun clmemo-indent-region (beg end)
  "Indent region with one TAB.

If `clmemo-indent-only-one-tab' is non-nil, do not indent line
that is already indented by tabs."
  (interactive "r*")
  (save-excursion
    (goto-char beg)
    (forward-line 0)
    (while (< (point) end)
      (unless (and clmemo-indent-only-one-tab 
		   (equal (following-char) ?\C-i))
	(insert "\t"))
      (forward-line 1))))

(defun clmemo-schedule ()
  "Insert schedule flags and puts date string.
See variable `clmemo-schedule-header' for header flag string."
  (interactive)
  (backward-paragraph)
  (forward-line 1)
  (search-forward "\t* " nil t)
  (insert clmemo-schedule-header)
  (search-forward ": ")
  (insert "[] ")
  (backward-char 2))

(defun clmemo-exit ()
  (interactive)
  (basic-save-buffer)
  (set-window-configuration clmemo-winconf))


(if (locate-library "clkwd")
    (require 'clkwd))
;;; clmemo.el ends here

;; Local Variables:
;; fill-column: 72
;; End:
