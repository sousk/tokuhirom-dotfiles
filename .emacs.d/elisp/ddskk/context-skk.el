;;; context-skk.el --- turning off skk when the point enters where skk is unnecessary -*- coding: iso-2022-jp -*-
;;
;; Copyright (C) 2003, 2005 Masatake YAMATO
;;
;; Author: Masatake YAMATO <jet@gyve.org>
;; Created: Tue May 13 19:12:23 2003
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.
;;
;;
;;; Commentary:
;; $B$3$N%W%m%0%i%`$O(Bskk$B$NF0:n!"?6Iq$$$K4X$7$F(B2$B$D$N5!G=$rDs6!$7$^$9!#(B
;;
;; (1) $BJT=8$NJ8L.$K1~$8$F<+F0E*$K(Bskk$B$N%b!<%I$r(Blatin$B$K@Z$jBX$($^$9!#(B
;; $BL@$+$K(Bskk$B$K$h$kF|K\8lF~NO$,I,MW$J$$8D=j$G!"(Bskk$B$r%*%s$K$7$?$^$^(B
;; $B%-!<A`:n$r9T$J$C$?$?$a$K(Bemacs$B$+$i%(%i!<$NJs9p$r<u$1$?$j!"$o$6$o$6(B
;; skk$B$r%*%U$K$7$F%F%-%9%H$r=$@5$9$k$N$OIT2w$G$9!#$3$l$rM^@)$9$k$3(B
;; $B$H$,!"$3$N5!G=$NL\E*$G$9!#(B
;;
;; $BJ8L.$NH=Dj$O(Bemacs lisp$B$K$h$C$F5-=R$G$-$^$9!#$3$N%W%m%0%i%`$K$O!"<!$N(B3$B$D(B
;; $B$NJ8L.$KBP$9$kH=Dj4X?t$,4^$^$l$F$$$^$9!#(B
;;
;; 1A. read-only$B$+$I$&$+(B
;; --------------------
;;    read-only$B%P%C%U%!$G$O!"F|K\8lF~NO$NI,MW$O$J$$$7!"$G$-$J$$$N$G!"F|(B
;;    $BK\8lF~NO$r%*%U$K$7$^$9!#$^$?(Bread-only$B$NNN0h$G$bF1MM$KF|K\8lF~NO$r(B
;;    off$B$K$7$^$9!#%(%i!<$NJs9p$r<u$1$k$+$o$j$K(Bskk$B$K$h$C$F%7%c%I%&$5$l(B
;;    $B$?85$N%-!<$K3dEv$F$i$l$?%3%^%s%I$r<B9T$G$-$^$9!#(B
;;
;; 1B. $B%W%m%0%i%`%3!<%ICf$G$N%3%a%s%H$dJ8;zNs$NFbB&$K$$$k$+(B
;; -------------------------------------------------------
;;    $B$"$k%W%m%0%i%_%s%08@8l$G%W%m%0%i%`$r=q$$$F$$$k$H$-!"F|K\8lF~NO$NI,MW$,(B
;;    $B$"$k$N$O0lHL$K!"$=$N%W%m%0%i%_%s%08@8l$NJ8;zNsCf$+%3%a%s%HCf$K8B$i$l$^(B
;;    $B$9!#J8;zNs!"%3%a%s%H$N!V30!W$rJT=8$9$k$H$-$O!"B?$/$N>l9gF|K\8lF~NO$OI,(B
;;    $BMW$"$j$^$;$s!#(B
;;    $B$?$H$($P(B emacs lisp$B$G$O!"(B
;;
;;    "$B!A(B" $B$d(B ;; $B!A(B
;;
;;    $B$H$$$C$?8D=j$G$@$1F|K\8lF~NO$,I,MW$H$J$j$^$9!#(B
;; 
;;    $B8=:_$NJ8;zNs$H%3%a%s%H$N!V30!W$GJT=83+;O$HF1;~$K(B
;;    (skk$B$,%*%s$G$"$l$P(B)skk$B$NF~NO%b!<%I$r(Blatin$B$K@Z$jBX$($^$9!#!V30!W$G$NJT=8(B
;;    $B$r3+;O$9$k$K$"$?$C$F!"F|K\8lF~NO$,(Bon$B$K$J$C$F$$$?$?$a$KH/@8$9$kF~NO8m$j(B
;;    $B$H$=$N=$@5A`:n$r2sHr$9$k$3$H$,$G$-$^$9!#(B
;;    
;; 1C. $B%-!<%^%C%W$,EPO?$5$l$F$$$k$+$I$&$+$rH=Dj(B
;; -------------------------------------------
;;    $B%]%$%s%H2<$K(B`keymap'$B$"$k$$$O(B`local-map'$B$NB0@-$r;}$DJ8;z$"$k$$$O%*!<%P%l%$$,(B
;;    $B$"$k$+$I$&$+$rD4$Y$^$9!#%-!<%^%C%W$,@_Dj$5$l$F$$$k>l9g!"$5$i$K(Bskk$B$GJl2;(B
;;    $B$NF~NO$K;H$&(B ?a, ?i, ?u, ?e, ?o$B$N%-!<$,%-!<%^%C%WCf$KDj5A$5$l$F$$$k$+D4(B
;;    $B$Y$^$9!#Dj5A$5$l$F$$$k>l9g!"%-!<%^%C%WCf$N%-!<$K3dEv$F$i$l$?5!G=$r<B9T(B
;;    $B$G$-$k$h$&F|K\8lF~NO$r%*%U$K$7$^$9!#(B
;;
;; $B<+?H$G(Bskk$B$r%*%U$K$9$kJ8L.$rDj5A$9$k$K$O!"(B
;; `context-skk-context-check-hook'
;; $BJQ?t$r;H$$$^$9!#(Bskk$B$NJ8;zF~NO4X?t(B`skk-insert'$B$N<B9TD>A0$K0z?tL5$7$G8F$S=P(B
;; $B$5$l!"(Bskk$B$r%*%U$K$9$kJ8L.$K$"$k$H$-(Bnon-nil$B$rJV$94X?t$rDj5A$7$F!"$3$NJQ?t(B
;; $B$K(B`add-hook'$B$7$F2<$5$$!#(B
;;
;; (2) $BJT=8$NJ8L.$K1~$8$F(Bskk$B$N@_Dj$rJQ99$7$^$9!#(B
;; skk$B$NJ8;zF~NO4X?t(B`skk-insert'$B$N$^$o$j$K(B`let'$B$rG[CV$7$F!"J8;zF~NOCf$K0l;~E*(B
;; $B$KJQ?t$NB+G{$rJQ99$7$F!"J8;zF~NO$N$?$S$K(Bskk$B$N@_Dj$rJQ99$G$-$^$9!#$3$N%W%m%0(B
;; $B%i%`$K$O!"(Bskk$B$K$h$k%F%-%9%H$NF~NO@h$N%P%C%U%!$r%9%-%c%s$7!"(B($B6gFIE@$N<oN`$r(B
;; $BI=$9(B)`skk-kutouten-type'$B$rJQ99$9$k4X?t$,4^$^$l$F$$$^$9!#(B
;;
;; $BFH<+$KJQ?t$r@_Dj$7$?$$>l9g!"4X?t$r=q$/I,MW$,$"$j$^$9!#(B
;; `context-skk-custumize-functions'$B$N%I%-%e%a%s%H$K=>$$!"4X?t$r=q$-!"(B
;;
;; (add-to-list 'context-skk-custumize-functions 
;;	        'your-on-the-fly-customize-func)
;;
;; $B$H$7$FEPO?$7$^$9!#(BM-x context-skk-dump-customize $B$K$h$k8=:_$N%]%$%s%H$KBP$7$F!"(B
;; context-skk$B$K$h$C$F0l<!E*$KB+G{$5$l$kJQ?t$H$=$NCM$NAH$r3NG'$G$-$^$9!#%G%P%C%0(B
;; $B$K3hMQ$7$F2<$5$$!#(B
;;
;; $B>e=R$7$?(B2$B$D$N5!G=$O(Bcontext-skk-mode$B$H$$$&%^%$%J!<%b!<%I$H$7$F<BAu$7$F$"$j$^$9!#(B
;; M-x context-skk-mode
;; $B$G(B $B%*%s(B/$B%*%U$r$G$-$^$9!#%b!<%I%i%$%s$K(B ";$B"&(B" $B$,I=<($5$l$F$$$k(B
;; $B>l9g!"$3$N%^%$%J!<%b!<%I$,(Bon$B$K$J$C$F$$$k$3$H$r0UL#$7$^$9!#(B
;;
;; - $B%$%s%9%H!<%k(B
;; (add-hook 'skk-load-hook
;;           '(require 'context-skk))
;;
;; - todo 
;; Handling the prefix arguments

;;; Code: 

;;
;; Custom
;;
;;;###autoload
(defgroup context-skk nil
  "Context-skk minor mode related customization."
  :group 'skk
  :prefix "context-skk-")

;;;###autoload
(defcustom context-skk-context-check-hook
  '(context-skk-out-of-string-or-comment-in-programming-mode-p
    context-skk-on-keymap-defined-area-p
    context-skk-in-read-only-p)
  "*$BF|K\8lF~NO$r<+F0E*$K(Boff$B$K$7$?$$!V%3%s%F%-%9%H!W$K$$$l$P(Bt$B$rJV$94X?t$rEPO?$9$k!#(B"
  :type 'hook
  :group 'context-skk)

;;;###autoload
(defcustom context-skk-custumize-functions 
  '(context-skk-customize-kutouten)
  "*skk$B$K$h$kF~NO3+;OD>A0$K!"F~NO$N%+%9%?%^%$%:$r9T$&$?$a$N4X?t$rEPO?$9$k!#(B
$B4X?t$O0J2<$N7A<0$N%G!<%?$rMWAG$H$9$k%j%9%H$rJV$9$b$N$H$9$k(B: 

  \(VARIABLE VALUE\)

`skk-insert'$B$r$+$3$`(B`let'$B$K$h$C$F(BVARIABLE$B$O(BVALUE$B$KB+G{$5$l$k!#(B
$BFC$K$=$N>l$G%+%9%?%^%$%:$9$Y$-JQ?t$,$J$$>l9g(B `nil'$B$rJV$;$PNI$$!#(B
$B4X?t$K$O2?$b0z?t$,EO$5$l$J$$!#(B"
  :type 'hook				; hook? list of function?
  :group 'context-skk)

;;;###autoload
(defcustom context-skk-programming-mode
  '(ada-mode antlr-mode asm-mode autoconf-mode awk-mode
    c-mode objc-mode java-mode idl-mode pike-mode cperl-mode
    ;;?? dcl-mode
    delphi-mode f90-mode fortran-mode
    icon-mode idlwave-mode inferior-lisp-mode lisp-mode m4-mode makefile-mode
    metafont-mode modula-2-mode octave-mode pascal-mode perl-mode
    prolog-mode ps-mode postscript-mode ruby-mode scheme-mode sh-mode simula-mode
    ;; sql-mode
    tcl-mode vhdl-mode emacs-lisp-mode)
  "*context-skk$B$K$F!V%W%m%0%i%_%s%0%b!<%I!W$H$_$J$9%b!<%I$N%j%9%H(B"
  :type '(repeat (symbol))
  :group 'context-skk)

;;
;; Minor mode definition
;;
;; Change autoload cookie for XEmacs.
;;;###autoload (autoload 'context-skk-mode "context-skk" "$BJ8L.$K1~$8$F<+F0E*$K(Bskk$B$NF~NO%b!<%I$r(Blatin$B$K@Z$j49$($k%^%$%J!<%b!<%I!#(B" t)
(define-minor-mode context-skk-mode
  "$BJ8L.$K1~$8$F<+F0E*$K(Bskk$B$NF~NO%b!<%I$r(Blatin$B$K@Z$j49$($k%^%$%J!<%b!<%I!#(B"
  t 
  :lighter " ;$B"&(B")

;;
;; Advices
;;
(defadvice skk-insert (around skk-insert-ctx-switch activate)
  "$BJ8L.$K1~$8$F<+F0E*$K(Bskk$B$NF~NO%b!<%I$r(Blatin$B$K$9$k!#(B"
  (if (and context-skk-mode (context-skk-context-check))
      (context-skk-insert) 
    (eval `(let ,(context-skk-custumize)
	     ad-do-it))))

(defadvice skk-jisx0208-latin-insert (around skk-jisx0208-latin-insert-ctx-switch activate)
  "$BJ8L.$K1~$8$F<+F0E*$K(Bskk$B$NF~NO%b!<%I$r(Blatin$B$K$9$k!#(B"
  (if (and context-skk-mode (context-skk-context-check))
      (context-skk-insert) 
    (eval `(let ,(context-skk-custumize)
	     ad-do-it))))

;;
;; Helper
;;
(defun context-skk-context-check ()
  "$BF|K\8lF~NO$r<+F0E*$K(Boff$B$K$7$?$$!V%3%s%F%-%9%H!W$K$$$l$P(Bt$B$rJV$9(B"
  (run-hook-with-args-until-success 'context-skk-context-check-hook))

(defun context-skk-custumize ()
  "$B%+%9%?%^%$%:$7$?$$JQ?t$HCM$NAH$rF@$k!#(B"
  (let (customized-pairs)
    (dolist (func context-skk-custumize-functions)
      (setq customized-pairs
	    (append 
	     (save-excursion (funcall func))
	     customized-pairs)))
    customized-pairs))

(defun context-skk-dump-customize ()
  "$B8=:_$N%]%$%s%H$N0LCV$K$*$1$k(B (context-skk-custumize) $B$N7k2L$rI=<($9$k!#(B"
  (interactive)
  (let ((customized-pairs (context-skk-custumize)))
    (with-output-to-temp-buffer "*context-skk customize result*"
      (pp customized-pairs))))

(defun context-skk-insert ()
  "skk-latin-mode$B$r(Bon$B$K$7$?>e(B`this-command-keys'$B$KBP$9$k4X?t$r8F$S=P$7D>$9!#(B"
  (message "[context-skk] $BF|K\8lF~NO(B off")
  (skk-latin-mode t)
  (let* ((keys (this-command-keys))
	 ;; `this-command-keys' $B$,(B tab $B$rJV$7$?$H$-$J$I(B function-key-map $B$d(B
	 ;; key-translation-map $B$K0MB8$7$F$$$k>l9g$O$=$l$i$N(B keymap $B$r;2>H$9$k(B
	 (binding (or (key-binding keys)
		      (key-binding (lookup-key function-key-map keys))
		      (key-binding (lookup-key key-translation-map keys)))))
    (when binding
      (call-interactively binding))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Predicators
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; $B%j!<%I%*%s%j!<$G$J$$$+!)(B
;;
(defun context-skk-in-read-only-p ()
  (or (context-skk-in-read-only-buffer-p)
      (context-skk-in-read-only-area-p)))

(defun context-skk-in-read-only-buffer-p ()
  buffer-read-only)

(defun context-skk-in-read-only-area-p ()
  (or 
   (and (get-char-property (point) 'read-only)
	(get-char-property (point) 'front-sticky))
   (and 
    (< (point-min) (point))
    (get-char-property (1- (point)) 'read-only)
    (not (get-char-property (1- (point)) 'rear-nonsticky)))))

;;
;; $BDL>oF|K\8lF~NO$rI,MW$H$7$J$$%W%m%0%i%_%s%0$N%b!<%I$K$$$k$+$I$&$+(B
;; $BJ8;zNs$rJT=8Cf$+$I$&$+(B
;; $B%3%a%s%H$rJT=8Cf$+$I$&$+(B
;;
(defun context-skk-out-of-string-or-comment-in-programming-mode-p ()
  "$B%W%m%0%i%_%s%0%b!<%I$K$"$C$FJ8;zNs$"$k$$$O%3%a%s%H$N30$K$$$l$P(Bnon-nil$B$rJV$9!#(B
$B%W%m%0%i%_%s%0%b!<%I$K$$$J$$>l9g$O(Bnil$B$rJV$9!#(B
$B%W%m%0%i%_%s%0%b!<%I$K$"$C$FJ8;zNs$"$k$$$O%3%a%s%H$NCf$K$$$k>l9g(Bnil$B$rJV$9!#(B"
  (and (context-skk-in-programming-mode-p) 
       (not (or (context-skk-in-string-p)
		(context-skk-in-comment-p)))))

(defun context-skk-in-programming-mode-p ()
  (memq major-mode
	context-skk-programming-mode))

(defun context-skk-in-string-p ()
  (nth 3 (parse-partial-sexp (point) (point-min))))
(defun context-skk-in-comment-p ()
  (nth 4 (parse-partial-sexp (point) (point-min))))

;;
;; $B8=:_$N%]%$%s%H2<$K(Bkeymap$B$,Dj5A$5$l$F$$$k$+$I$&$+!)(B
;;
(defun context-skk-on-keymap-defined-area-p ()
  (or (context-skk-on-vowel-key-reserved-p 'keymap)
      (context-skk-on-vowel-key-reserved-p 'local-map)))

(defun context-skk-on-vowel-key-reserved-p (map-symbol)
  (let ((map (get-char-property (point) map-symbol)))
    (when map
      ;; "$B$"$$$&$($*(B"$B$rF~NO$9$k$3$H$rA[Dj$7$F%A%'%C%/$9$k!#(B
      (or (lookup-key map "a")
	  (lookup-key map "i")
	  (lookup-key map "u")
	  (lookup-key map "e")
	  (lookup-key map "o")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Customize function
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; $B6gFIE@(B(skk-kutouten-type)
;;
;; Based on a post to skk ml by 
;; Kenichi Kurihara (kenichi_kurihara at nifty dot com)
;; Message-ID: <m2y85qctw6.wl%kurihara@mi.cs.titech.ac.jp>
;;
(defun context-skk-customize-kutouten ()
  (let ((kuten-jp  (context-skk-customize-regexp-scan "$B!#(B" 'forward 0 nil))
	(kuten-en  (context-skk-customize-regexp-scan "$B!%(B" 'forward 0 nil))
	(touten-jp (context-skk-customize-regexp-scan "$B!"(B" 'forward 0 nil))
	(touten-en (context-skk-customize-regexp-scan "$B!$(B" 'forward 0 nil)))
    (if (or (eq kuten-jp kuten-en)
	    (eq touten-jp touten-en))
	nil ;; Nothing to customize
      `((skk-kutouten-type 
	 ',(if kuten-jp
	      (if touten-jp 
		  'jp
		'jp-en)
	    (if touten-jp 
		'en-jp
	      'en)))))))
      
(defun context-skk-customize-regexp-scan (regexp direction from limit)
  (let ((func (if (eq direction 'forward)
		  're-search-forward
		're-search-backward)))
    (save-excursion
      (goto-char from)
      (if (funcall func regexp limit t) 
	  t
	nil))))

(provide 'context-skk)
;; context-skk.el ends here
