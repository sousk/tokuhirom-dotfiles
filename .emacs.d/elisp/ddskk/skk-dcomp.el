;;; skk-dcomp.el --- SKK dynamic completion -*- coding: iso-2022-jp -*-

;; Copyright (C) 1999, 2000, 2001 NAKAJIMA Mikio <minakaji@osaka.email.ne.jp>

;; Author: NAKAJIMA Mikio <minakaji@osaka.email.ne.jp>
;; Maintainer: SKK Development Team <skk@ring.gr.jp>
;; Version: $Id: skk-dcomp.el,v 1.43 2007/04/29 01:38:17 skk-cvs Exp $
;; Keywords: japanese, mule, input method
;; Last Modified: $Date: 2007/04/29 01:38:17 $

;; This file is part of Daredevil SKK.

;; Daredevil SKK is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.

;; Daredevil SKK is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Daredevil SKK, see the file COPYING.  If not, write to
;; the Free Software Foundation Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary

;; $B$3$l$O"&%b!<%I$K$*$1$k8+=P$78l$NF~NO$r!"<+F0E*$K%@%$%J%_%C%/$K%3%s%W(B
;; $B%j!<%7%g%s$9$k%W%m%0%i%`$G$9!#(B
;;
;; MS Excel $B$N%;%kF~NO$N<+F0Jd40(B ($BF1$8Ns$K4{$KF~NO$7$F$$$kJ8;zNs$,$"$C(B
;; $B$?$H$-$K$=$l$r;2>H$7$FJd40$7$h$&$H$9$k5!G=(B) $B$r8+$F$$$F!"$3$lJXMx$@$J$!(B
;; $B$H;W$C$?$N$,!"3+H/$N$-$C$+$1$G$9!#(B
;;
;; $B$=$N8e!"A}0f=SG7(B $B$5$s$,3+H/$7$F$$$k(B POBox $B$r8+$F!"(BMS Excel $B$r8+$?:]$K(B
;; $B;W$C$?$3$H$r;W$$=P$7!"(BSKK $B$N(B skk-comp.el $B$GDs6!$5$l$F$$$k%3%s%W%j!<%7(B
;; $B%g%s$N5!G=$r<+F0E*$KDs6!$9$kJ}8~$G<BAu$7$F$_$?$N$,(B skk-dcomp.el $B$N%3!<(B
;; $B%G%#%s%0;O$^$j$G$9!#(B
;;
;; POBox $B$OBt;38uJd$r=P$7$^$9$,!">/$7F0:n$,CY$$$N$,FqE@$G$9!#(Bskk-dcomp.el
;; $B$O0l$D$7$+8uJd$r=P$7$^$;$s$,!"%f!<%6$N8+=P$78l$NF~NO$KDI=>$7%@%$%J%_%C(B
;; $B%/$K%3%s%W%j!<%7%g%s$9$k5!G=$O(B POBox $BF1MM;}$C$F$$$^$9$7!"$^$?F0:n$O$+$J(B
;; $B$j9bB.$G!"(Bskk-dcomp.el $B$r;H$&$3$H$K$h$k%*!<%P!<%X%C%I$rBN46$9$k$3$H$O$J(B
;; $B$$$H;W$$$^$9!#(B
;;
;;
;; <INSTALL>
;;
;; SKK $B$rIaDL$K(B make $B$7$F2<$5$$!#FC$K:n6H$OITMW$G$9!#(B
;;
;; <HOW TO USE>
;;
;; .emacs $B$b$7$/$O(B .skk $B$K(B (setq skk-dcomp-activate t) $B$H=q$-$^$7$g$&!#(B
;; SKK $B5/F08e$K%@%$%J%_%C%/%3%s%W%j!<%7%g%s$N5!G=$r;_$a$?$+$C$?$i!"(B
;; (setq skk-dcomp-activate nil) $B$rI>2A$7$^$7$g$&!#(B
;;
;;
;; <HOW TO WORK>
;;
;; $B"&%b!<%I$KF~$j8+=P$78l$rF~NO$9$k$H!"8D?M<-=q$r<+F0E*$K8!:w$7!"8+=P(B
;; $B$78l$r(B $B%3%s%W%j!<%7%g%s$7$^$9!#2<5-$N$h$&$KF0:n$7$^$9(B ($B%+%C%3Fb$O%-!<(B
;; $BF~NO$r!"(B-!- $B$O%]%$%s%H0LCV$rI=$7$^$9(B)$B!#(B
;;
;;   (Ho) $B"&$[(B -> $B"&$[(B-!-$B$s$H$&(B
;;
;;   * SKK $B$N%3%s%W%j!<%7%g%s$O!"85Mh8D?M<-=q$N$_$r;2>H$7$F9T$J$o$l$k(B
;;     $B;EMM$K$J$C$F$$$^$9$N$G!"8D?M<-=q$K$J$$8+=P$78l$N%3%s%W%j!<%7%g%s(B
;;     $B$O9T$J$o$l$^$;$s!#(B
;;   * $B%3%s%W%j!<%7%g%s$O!"Aw$j$J$7JQ49$N>l9g$7$+9T$J$o$l$^$;$s!#(B
;;   * Ho $B$NF~NO$KBP$7!"!V$[$s$H$&!W$,%3%s%W%j!<%7%g%s$5$l$k$+$I$&$+$O8D(B
;;     $B?M<-=q$N%(%s%H%j$N=gHV<!Bh(B ($BJQ49=g$K9_=g$KJB$s$G$$$k(B) $B$G$9$N$G!"?M(B
;;     $B$=$l$>$l0c$&$O$:$G$9!#(B
;;
;; $B<+F0E*$K%3%s%W%j!<%7%g%s$5$l$?8+=P$78l$,!"<+J,$N0U?^$7$?$b$N$G$"$l$P(B TAB
;; $B$r2!$9$3$H$G%]%$%s%H0LCV$rF0$+$7!"%3%s%W%j!<%7%g%s$5$l$?8+=P$78l$rA*Br$9(B
;; $B$k$3$H$,$G$-$^$9!#$=$N$^$^(B SPC $B$r2!$7$FJQ49$9$k$J$j!"(Bq $B$r2!$7$F%+%?%+%J(B
;; $B$K$9$k$J$j(B SKK $BK\Mh$NF0:n$r2?$G$b9T$J$&$3$H$,$G$-$^$9!#(B
;;
;;   (Ho) $B"&$[(B -> $B"&$[(B-!-$B$s$H$&(B (TAB) -> $B"&$[$s$H$&(B-!- (TAB)
;;
;; $B%3%s%W%j!<%7%g%s$5$l$?8+=P$78l$,<+J,$N0U?^$7$?$b$N$G$J$$>l9g$O!"$+$^(B
;; $B$o$:<!$NF~NO$r$7$F2<$5$$!#%3%s%W%j!<%7%g%s$5$l$?ItJ,$rL5;k$7$?$+$N$h$&$K(B
;; $BF0:n$7$^$9!#(B
;;
;;   (Ho) $B"&$[(B -> $B"&$[(B-!-$B$s$H$&(B (ka) -> $B"&$[$+(B-!-$B$s(B
;;
;; $B%3%s%W%j!<%7%g%s$5$l$J$$>uBV$,<+J,$N0U?^$7$?$b$N$G$"$k>l9g$b!"%3%s%W%j!<(B
;; $B%7%g%s$5$l$?ItJ,$rC1$KL5;k$9$k$@$1$G(B OK $B$G$9!#(B
;;
;;   (Ho) $B"&$[(B -> $B"&$[(B-!-$B$s$H$&(B (C-j) -> $B$[(B
;;   (Ho) $B"&$[(B -> $B"&$[(B-!-$B$s$H$&(B (SPC) -> $B"'J](B ($B!V$[!W$r8+=P$78l$H$7$?JQ49$,(B
;;                                       $B9T$J$o$l$k(B)
;;   (Ho) $B"&$[(B -> $B"&$[(B-!-$B$s$H$&(B (q) -> $B%[(B
;;
;; $B%3%s%W%j!<%7%g%s$5$l$?>uBV$+$i(B BS $B$r2!$9$H!">C$5$l$?%3%s%W%j!<%7%g%sA0$N(B
;; $B8+=P$78l$+$i:FEY%3%s%W%j!<%7%g%s$r9T$J$$$^$9!#(B
;;
;;   (Ho) $B"&$[(B -> $B"&$[(B-!-$B$s$H$&(B (ka) -> $B"&$[$+(B-!-$B$s(B (BS) -> $B"&$[(B-!-$B$s$H$&(B

;;; Code:

(eval-when-compile
  (require 'skk-macs)
  (require 'skk-vars))
(require 'skk-comp)

;;; functions.
;; (defsubst skk-extentp (object)
;;   (static-cond
;;    ((eq skk-emacs-type 'xemacs) (extentp object))
;;    (t (overlayp object))))

(defsubst skk-dcomp-face-on (start end)
  (skk-face-on skk-dcomp-extent start end skk-dcomp-face
	       skk-dcomp-face-priority))

(defsubst skk-dcomp-face-off ()
  (skk-detach-extent skk-dcomp-extent))

(defsubst skk-dcomp-delete-completion ()
  (ignore-errors
    (delete-region skk-dcomp-start-point skk-dcomp-end-point)))

;;;###autoload
(defun skk-dcomp-marked-p ()
  (and (eq skk-henkan-mode 'on)
       (markerp skk-dcomp-start-point)
       (markerp skk-dcomp-end-point)
       (marker-position skk-dcomp-start-point)
       (marker-position skk-dcomp-end-point)
       (< skk-dcomp-start-point skk-dcomp-end-point)))

(defun skk-dcomp-cleanup-buffer ()
  (when (and skk-dcomp-activate
	     (skk-dcomp-marked-p))
    (skk-dcomp-face-off)
    (delete-region skk-dcomp-end-point (point))
    (skk-set-marker skk-dcomp-end-point (point))))

(defun skk-dcomp-activate-p ()
  (and skk-dcomp-activate
       (cond ((functionp skk-dcomp-activate)
	      (save-match-data
		(funcall skk-dcomp-activate)))
	     ((listp skk-dcomp-activate)
	      (save-match-data
		(eval skk-dcomp-activate)))
	     (skk-hint-inhibit-dcomp
	      nil)
	     (t
	      t))))

(defun skk-dcomp-do-completion (pos)
  (when (and (eq skk-henkan-mode 'on)
	     (not skk-okurigana)
	     (not (eq (marker-position skk-henkan-start-point) (point)))
	     (skk-dcomp-activate-p))
    (condition-case nil
	(progn
	  (skk-comp-do 'first 'silent)
	  (skk-set-marker skk-dcomp-start-point pos)
	  (skk-set-marker skk-dcomp-end-point (point))
	  (skk-dcomp-face-on skk-dcomp-start-point skk-dcomp-end-point)
	  (goto-char skk-dcomp-start-point))
      (error
       (setq skk-comp-stack nil)
       (message nil)))))

;;;###autoload
(defun skk-dcomp-before-kakutei ()
  (when (and skk-dcomp-activate
	     (eq skk-henkan-mode 'on)
	     (skk-dcomp-marked-p))
    (skk-dcomp-face-off)
    (skk-dcomp-delete-completion)))

(defun skk-dcomp-after-kakutei ()
  (when skk-dcomp-activate
    (skk-set-marker skk-dcomp-start-point nil)
    (skk-set-marker skk-dcomp-end-point nil)
    (setq skk-comp-stack nil)))

;;;###autoload
(defun skk-dcomp-after-delete-backward-char ()
  (when (and skk-dcomp-activate
	     skk-mode
	     (eq skk-henkan-mode 'on)
	     (not skk-hint-inhibit-dcomp))
    (when (skk-dcomp-marked-p)
      (skk-dcomp-face-off)
      (skk-dcomp-delete-completion))
    (when (and skk-abbrev-mode
	       skk-use-look)
      (setq skk-look-completion-words nil))
    (skk-dcomp-do-completion (point)))
  ;; dcomp $B$H$N=gHV@)8f$N$?$a!"$3$3$G8F$V(B
  (skk-henkan-on-message))

;;; advices.
;; main dynamic completion engine.
(defadvice skk-kana-input (around skk-dcomp-ad activate)
  (cond
   ((or skk-hint-inhibit-dcomp
	(not (and skk-dcomp-activate
		  skk-henkan-mode)))
    ad-do-it)
   (t
    (cond
     ((or (eq skk-henkan-mode 'active)
	  (skk-get-prefix skk-current-rule-tree)
	  (not skk-comp-stack))
      (skk-set-marker skk-dcomp-start-point nil)
      (skk-set-marker skk-dcomp-end-point nil))
     ((skk-dcomp-marked-p)
      (skk-dcomp-face-off)
      (unless (member (this-command-keys)
		      skk-dcomp-keep-completion-keys)
	(skk-dcomp-delete-completion))))
    ad-do-it
    (when (and skk-j-mode
	       (or skk-use-kana-keyboard
		   ;; $BAw$j$"$jJQ49$,;O$^$C$?$iJd40$7$J$$(B
		   (not (memq last-command-char skk-set-henkan-point-key)))
	       (not (skk-get-prefix skk-current-rule-tree)))
      (skk-dcomp-do-completion (point))))))

(defadvice skk-set-henkan-point-subr (around skk-dcomp-ad activate)
  (cond
   (skk-dcomp-activate
    (let ((henkan-mode skk-henkan-mode))
      ad-do-it
      (unless (or henkan-mode
		  (char-after (point)))
	(skk-dcomp-do-completion (point)))))
   (t
    ad-do-it)))

(defadvice skk-abbrev-insert (around skk-dcomp-ad activate)
  (cond
   (skk-dcomp-activate
    (when (skk-dcomp-marked-p)
      (skk-dcomp-face-off)
      (skk-dcomp-delete-completion))
    ad-do-it
    (when skk-use-look
      (setq skk-look-completion-words nil))
    (unless (memq last-command-char '(?*))
      (skk-dcomp-do-completion (point))))
   (t
    ad-do-it)))

(defadvice skk-abbrev-comma (around skk-dcomp-ad activate)
  (cond
   ((and skk-dcomp-activate
	 (not (eq last-command 'skk-comp-do)))
    (when (skk-dcomp-marked-p)
      (skk-dcomp-face-off)
      (skk-dcomp-delete-completion))
    ad-do-it
    (when skk-use-look
      (setq skk-look-completion-words nil))
    (unless (memq last-command-char '(?*))
      (skk-dcomp-do-completion (point))))
   (t
    ad-do-it)))

(defadvice skk-abbrev-period (around skk-dcomp-ad activate)
  (cond
   ((and skk-dcomp-activate
	 (not (eq last-command 'skk-comp-do)))
    (when (skk-dcomp-marked-p)
      (skk-dcomp-face-off)
      (skk-dcomp-delete-completion))
    ad-do-it
    (when skk-use-look
      (setq skk-look-completion-words nil))
    (unless (memq last-command-char '(?*))
      (skk-dcomp-do-completion (point))))
   (t
    ad-do-it)))

(defadvice skk-kakutei (around skk-dcomp-ad activate)
  (skk-dcomp-before-kakutei)
  ad-do-it
  (skk-dcomp-after-kakutei))

(defadvice keyboard-quit (around skk-dcomp-ad activate)
  (skk-dcomp-before-kakutei)
  ad-do-it
  (skk-dcomp-after-kakutei))

;;(defadvice skk-henkan (before skk-dcomp-ad activate)
(defadvice skk-start-henkan (before skk-dcomp-ad activate)
  (skk-dcomp-cleanup-buffer))

(defadvice skk-process-prefix-or-suffix (before skk-dcomp-ad activate)
  (when skk-henkan-mode
    (skk-dcomp-cleanup-buffer)))

(defadvice skk-comp (around skk-dcomp-ad activate)
  (cond ((and skk-dcomp-activate
	      (skk-dcomp-marked-p))
	 (cond ((integerp (ad-get-arg 0))
		(skk-dcomp-cleanup-buffer)
		ad-do-it)
	       (t
		(goto-char skk-dcomp-end-point)
		(setq this-command 'skk-comp-do)
		(skk-dcomp-face-off)
		(skk-set-marker skk-dcomp-start-point nil)
		(skk-set-marker skk-dcomp-end-point nil))))
	(t
	 ad-do-it)))

(defadvice skk-comp-start-henkan (around skk-dcomp-ad activate)
   (cond ((and (eq skk-henkan-mode 'on)
	       skk-dcomp-activate
	       (skk-dcomp-marked-p))
	  (goto-char skk-dcomp-end-point)
	  (setq this-command 'skk-comp-do)
	  (skk-dcomp-face-off)
	  (skk-set-marker skk-dcomp-start-point nil)
	  (skk-set-marker skk-dcomp-end-point nil)
	  (skk-start-henkan (ad-get-arg 0)))
	 (t
	  ad-do-it)))

(defadvice skk-delete-backward-char (after skk-dcomp-ad activate)
  (skk-dcomp-after-delete-backward-char))

(defadvice viper-del-backward-char-in-insert (after skk-dcomp-ad activate)
  (skk-dcomp-after-delete-backward-char))

(defadvice vip-del-backward-char-in-insert (after skk-dcomp-ad activate)
  (skk-dcomp-after-delete-backward-char))

(require 'product)
(product-provide
    (provide 'skk-dcomp)
  (require 'skk-version))

;;; skk-dcomp.el ends here
