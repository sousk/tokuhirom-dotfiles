;;; w3-wget.el --- Interface program of wget on emacs-w3.

;; Copyright (C) 2002 Masayuki Ataka <ataka@milk.freemail.ne.jp>
;;	$Id: w3-wget.el,v 1.1 2005/09/16 03:53:25 tokuhiro Exp $	

;; Authors: Masayuki Ataka <ataka@milk.freemail.ne.jp>
;; Keywords: w3, WWW, hypermedia

;; This file is a part of emacs-wget.

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


;;; Code:
(autoload 'wget-api "wget" "Application Program Interface for wget")

(defun w3-wget (arg)
  "Downlod anchor, image, or current page.
With prefix argument ARG, you can change uri and wget options."
  (interactive "P")
  (let ((current-uri (url-recreate-url url-current-object))
	(uri (w3-view-this-url t)))
    (wget-api uri current-uri arg)))


(provide 'w3-wget)
;;; w3-wget.el ends here
