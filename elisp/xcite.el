;;; -*- Emacs-Lisp -*-
;;;  exciting cite utility
;;; (c)1996-2003 by HIROSE Yuuji [yuuji@gentei.org]
;;; $Id: xcite.el,v 1.1 2005/09/16 03:53:25 tokuhiro Exp $
;;; Last modified Wed Feb  5 23:31:15 2003 on firestorm
;;; Update count: 463

;;[Commentary]
;;
;;	This package enables you to register  as many mail/news citation
;;	prefix as you like according to each author, and to select those
;;	headers randomly.
;;
;;	xcite$B$r;H$&$H!"%a%$%k$d%K%e!<%9$NB><T$N5-;v$N0zMQ;~$K!"9TF,$KIU(B
;;	$B2C$9$kH/8@<T$rI=$9(B $B!V9-@%(B>$B!W(B $B$N$h$&$J0zMQJ8;zNs(B($B0J8e0zMQ%?%0(B)$B$r!"(B
;;	$B$=$NAj<jKh$KEPO?$G$-$^$9!#0zMQ%?%0$rJ#?t8DEPO?$9$k$H0zMQ;~$K$=$l(B
;;	$B$i$r%i%s%@%`$KA*$V$3$H$,$G$-$^$9!#$?$/$5$sEPO?$7$F$*$/$H$I$l$,=P(B
;;	$B$FMh$k$+J,$+$i$J$$$N$G!"$J$+$J$+%(%-%5%$%F%#%s%0$G$9(B($B$&$=(B)$B!#(BC-u
;;	$B$rIU$1$F$+$i(Bxcite$B$r8F$V$H!"%_%K%P%C%U%!$GJ#?t$N0zMQ%?%0$r(B C-n $B$d(B
;;	C-p $B$GA*Br$7$?$j!"?7$?$J%?%0$G0zMQ$9$k$3$H$,$G$-$^$9!#JQ?t$N@_Dj(B
;;	$B$K$h$j!"!V%G%U%)%k%H$GA*Br!"(BC-u$B$rIU$1$?$i%i%s%@%`!W$H$$$&$h$&$K(B
;;	$B5sF0$rJQ99$9$k$3$H$,$G$-$^$9!#(B
;;
;;	xcite $B$O(B Emacs $B>e$GJV;v$r=q$/$b$N$G$"$l$P!"(Bmh-e, mew, gnus $B$J$I!"(B
;;	$B$"$i$f$k%Q%C%1!<%8$HAH$_9g$o$;$F;H$&$3$H$,=PMh$^$9!#$^$?!"B>$N%Q%C(B
;;	$B%1!<%8$N0zMQ4X?t$N%U%C%/$H$7$FF/$/$N$G$O$J$/!"A4$F<+NO$G0zMQJ8$r(B
;;	$B:n@.$9$k$N$G!">e5-$N%Q%C%1!<%8$,$J$/$F$bF0:n$7$^$9!#(B
;;
;;	The latest xcite.el is always available at;
;;	http://www.gentei.org/~yuuji/software/xcite.el
;;
;;[Warning]
;;
;;	You can use this package freely unless you cite your own article
;;	with  a first-person citation  prefix, as  `me' which  will lose
;;	information in the future citation.
;;
;;	xcite$B$O$I$J$?$G$b$4<+M3$K$*;H$$D:$1$^$9!#$?$@$7!"<+J,<+?H$N5-;v(B
;;	$B$r0zMQ$9$k$H$-$K!"!V;d(B>$B!W$N$h$&$J0l?M>N$r;H$o$J$$$G2<$5$$!#!V;d(B>$B!W(B
;;	$B$J$I$G0zMQ$9$k$H!"$5$i$K0zMQ$5$l$?$H$-$K0lBNC/$N5-;v$J$N$+J,$+$i(B
;;	$B$:!"$=$l$J$i$`$7$mC1=c$K!V(B>$B!W$G0zMQ$r7+$jJV$7$?J}$,$O$k$+$K$^$7(B
;;	$B$H$$$($k$+$i$G$9!#(B
;;
;;[Installation]
;;
;;	Put these lines into your ~/.emacs
;;	$B0J2<$NFs$D$OI,$:I,MW$G$9!#(B
;;
;;		(autoload 'xcite "xcite" "Exciting cite" t)
;;		(autoload 'xcite-yank-cur-msg "xcite" "Exciting cite" t)
;;
;;	and assign your favorite key stroke to these functions.
;;	$BE,Ev$J%-!<$K(B2$B4X?t$r3d$jEv$F$F2<$5$$!#0J2<$NNc$G$O!"(BC-c C-x $B$K(B
;;	xcite$B%a%K%e!<$r!"(BC-c C-y $B$K0zMQ$r3d$jEv$F$^$9!#(B
;;
;;	(ex.)	(global-set-key "\C-c\C-x" 'xcite)
;;		(global-set-key "\C-c\C-y" 'xcite-yank-cur-msg)
;;
;;	If you are using mh, mew, gnus, etc., set appropriate hook to
;;	bind xcite's functions on their draft buffer.
;;	$B;H$C$F$$$k%a%$%k(B/$B%K%e!<%9%j!<%@$K1~$8$F!"0J2<$N$h$&$K(Bhook$B$r@_Dj(B
;;	$B$7$F2<$5$$!#(B
;;
;;	      (setq mh-letter-mode-hook	; mh-e$B$N>l9g(B
;;		    '(lambda ()
;;		       (define-key mh-letter-mode-map "\C-c\C-y"
;;			 'xcite-yank-cur-msg)))
;;	      (setq mew-draft-mode-hook	; mew$B$N>l9g(B
;;		    '(lambda ()
;;		       (define-key mew-draft-mode-map "\C-c\C-y"
;;			 'xcite-yank-cur-msg))
;;		    mew-init-hook
;;		    '(lambda ()
;;		       (define-key mew-summary-mode-map "A"
;;			 '(lambda () (interactive)
;;			    (mew-summary-reply)
;;			    (xcite-yank-cur-msg)))))
;;	      (setq news-reply-mode-hook ; GNUS4$B$N>l9g(B
;;		    '(lambda ()
;;		       (define-key news-reply-mode-map "\C-c\C-y"
;;			 'xcite-yank-cur-msg)))
;;
;;	If your are using Wanderlust, set like this:
;;	Wanderlust$B$r$*;H$$$N>l9g$O0J2<$N$h$&$K$7$^$9!#(B
;;
;;	; Wanderlust 2.6 series
;;	(autoload 'xcite-indent-citation "xcite")
;;	(setq wl-draft-cite-func 'xcite-indent-citation)
;;
;;	; Wanderlust 2.7 or later
;;	(autoload 'xcite-indent-citation "xcite")
;;	(setq wl-draft-cite-function 'xcite-indent-citation)
;;
;;
;;	If you are using GNUS5 or later, such as Semi-gnus, set
;;	appropriately as follows:
;;	Semi-gnus$B$J$I$N(BGNUS5$B0J9_$NHG$N(BGnus$B$r$*;H$$$N>l9g$O<!$N$h$&$K@_(B
;;	$BDj$7$F$/$@$5$$!#(B
;;
;;		(autoload 'xcite-indent-citation "xcite")
;;		(setq message-citation-line-function nil
;;		      message-indent-citation-function
;;		      'xcite-indent-citation)
;;
;;	And xcite 1.26 or later recognize "X-cite-me" extensional header
;;	to decide the article author's preferring citation.  If you wish
;;	your correspondent to cite your message with certain citation
;;	prefix, put the "X-cite-me: YourName" header in your mail
;;	draft.  Of course this function will be achieved only when your
;;	correspondent uses new xcite.el.  Here is the sample definition
;;	for mew to put "X-cite-me" header.
;;
;;	xcite 1.26$B0J9_$G$O!"(B"X-cite-me:" $B%X%C%@$rG'<1$9$k$h$&$K$7$^$7$?!#(B
;;	$B$3$l$O<+J,$,$I$&$$$&J8;zNs$G0zMQ$7$FM_$7$$$+$r;XDj$9$k$?$a$N%X%C(B
;;	$B%@$G!"Aj<j$,(Bxcite1.26$B0J9_$rMQ$$$F$$$k$H$-$K<+J,$NJ8>O$N0zMQ%?%0(B
;;	$B$r;XDj$G$-$^$9!#0J2<$K!"(BMew, Wanderlust $B$rMQ$$$F$$$k>l9g$N(B
;;	X-cite-me $B%X%C%@$N<+F0A^F~@_Dj$r<($7$^$9!#(B
;;
;;		;;for Mew
;;		(setq mew-header-alist '(("X-cite-me:" . "yuuji")))
;;		;;for Wanderlust
;;		(setq wl-draft-config-alist
;;		      '((t
;;			 ("X-cite-me" . "yuuji"))))
;;
;;[How to Use]
;;
;;  * M-x xcite-yank-cur-msg (or C-c C-y)
;;
;;	This  function yanks message   in the next window  with citation
;;	prefix corresponding  to its author.  If you  have not cited the
;;	author's article  ever, Xcite asks  you the citation string with
;;	GCOS name defaulted.    If you give some  string  to the prompt,
;;	that citation string will be used in the next call.
;;
;;	$B%a%$%k$d%K%e!<%9$N869F$r=q$$$F$$$k%P%C%U%!$G<B9T$9$k$H!"NY$N%&%#(B
;;	$B%s%I%&$K8+$($F$$$k5-;v$r!"$=$NH/?.<T$K1~$8$?0zMQ%?%0$rIU$1$F%+%l(B
;;	$B%s%H%P%C%U%!$K%d%s%/$7$^$9!#$b$7$=$NH/?.<T$K1~$8$?0zMQ%?%0$rEPO?(B
;;	$B$7$F$$$J$$>l9g$O0zMQ%?%0$NF~NO$,5a$a$i$l$^$9!#$3$3$G0zMQL>$rF~NO(B
;;	$B$7$?>l9g$K$O<!2s$+$i$=$N0zMQL>$rMQ$$$?0zMQ%?%0$,A^F~$5$l$^$9!#2?(B
;;	$B$bF~NO$7$J$+$C$?>l9g$O!"(BFrom: $B9T$N(BGCOS$BL>$,%G%U%)%k%H$GMQ$$$i$l$^(B
;;	$B$9!#(B
;;
;;  * C-u M-x xcite-yank-cur-msg (or C-u C-c C-y)
;;
;;	Once you've registered   citation strings to some author,  Xcite
;;	selects one of them at random.  C-u for this function make Xcite
;;	allow you  to  select by C-n  and C-p, or  enter a new  citation
;;	string.  If you enter a new one, it will be added to the list.
;;
;;	$BFCDj$NH/?.<T$KBP$9$k0zMQ%?%0$rEPO?$7$?>l9g!"<!2s$+$i$O$=$l$i$NCf(B
;;	$B$+$i%i%s%@%`$K%?%0$,A*$P$l$F0zMQ$5$l$k$h$&$K$J$j$^$9!#(BC-u $B$rIU$1(B
;;	$B$F$3$N4X?t$r8F$V$H!"%_%K%P%C%U%!$GJ#?t8uJd$+$i(B C-n $B$d(B C-p $B$G9%$-(B
;;	$B$J$b$N$rA*$s$@$j!"?7$?$J0zMQ%?%0$rF~NO$9$k$3$H$,$G$-$^$9!#?7$7$$(B
;;	$B$b$N$rF~$l$?>l9g$O!"<!2s$+$i$NA*Br8uJd$KDI2C$5$l$^$9!#(B
;;
;;  * M-x xcite (or C-c C-x)
;;
;;	This function displays this menu;
;;	$B0J2<$N%a%K%e!<$,=P$FMh$^$9!#(B
;;
;;	  Y)ank W)copy A)ppend P)repend I)nsertPrefix R)egionCite Q)fill
;;
;;	`y' is equivalent to M-x xcite-yank-cur-msg.  `C-u' for M-x
;;	xcite will be passed to xcite-yank-cur-msg.
;;	y $B$O(B M-x xcite-yank-cur-msg (C-c C-y) $B$HF1$8$G$9!#(B
;;
;;	`w' incorporates marked   region with citation prefix  into yank
;;	buffer.  If you want  to cite more than one  article, you can do
;;	that by visiting   other article to   mark  region you want   to
;;	include and calling  M-x xcite `w'.    The next yank  (C-y) will
;;	paste   that region with  citation  header  and citation prefix.
;;	`C-u' for M-x xcite makes Xcite let you select citation prefix.
;;	w $B$O%+%l%s%H%P%C%U%!$N%^!<%/$7$?%j%8%g%s$K0zMQ%?%0$rIU$1$?$b$N$r(B
;;	$B%d%s%/%P%C%U%!$K3JG<$7$^$9!#$b$7!"0lDL$N5-;v$KJ#?t$N5-;v$r0zMQ$7(B
;;	$B$?$$>l9g$O!"0zMQ$7$?$$5-;v$N$"$k%P%C%U%!$K0\F0$70zMQ$7$?$$HO0O$r(B
;;	$B%^!<%/$7$F$3$N4X?t$r8F$S!"=q$$$F$$$k%P%C%U%!$KLa$C$F%d%s%/(B(C-y)
;;	$B$9$k$HNI$$$G$7$g$&!#(B
;;
;;	(*1)
;;	`a' and  `p' are  the same with  `w' except  they append/prepend
;;	cited  lines to  kill-ring instead  of replacing  it,  which `w'
;;	command does.   This is handy for citing  messages from multiple
;;	articles.
;;	a $B$H(B p $B$O!">e5-(B w $B$HF1MM%^!<%/$7$?NN0h$r<h$j9~$_$^$9$,!"%d%s%/%P%C(B
;;	$B%U%!$KDI2C$7$^$9(B(a$B$G8e$m$KDI2C!"(Bp$B$G@hF,$KDI2C(B)$B!#J#?t$N5-;v$+$i0l(B
;;	$BEY$K0zMQ$9$k$H$-$K;H$&$HJXMx$G$9!#(B
;;
;;	`i' inserts the current citation prefix in the current line.
;;	i $B$O8=:_$N0zMQ%?%0$r%+%l%s%H9T$KA^F~$7$^$9!#(B
;;
;;	`r' does the same as `i' on each line in the region.
;;	r $B$O%^!<%/$7$?%j%8%g%s$N3F9T$KBP$7(B i $B$HF1MM0zMQ%?%0$rA^F~$7$^$9!#(B
;;
;;	`q' fills the current cited paragraph.
;;	q $B$O0zMQ$5$l$?%Q%i%0%i%U$r0zMQ%?%0$r9MN8$7$F(Bfill$B$7$^$9!#(B
;;
;;[FAQ]
;;
;;  * Lines which contains `>' or blank lines aren't cited.
;;
;;	Yes, that's the  specification.  That is  the style of named tag
;;	citation.   Lines  which  is already   cited  with author's name
;;	should not be cited twice or more.   But sometimes xcite ignores
;;	a line which simply contains  `>', and which  is not cited.   In
;;	this case, insert citation tag manually by M-x xcite and `i'.
;;
;;  * $B6u9T$d!V(B>$B!W$r4^$`9T$K0zMQ%?%0$,A^F~$5$l$J$$(B
;;
;;	$B;EMM$G$9!#L>A0IU$-%?%0$G0zMQ$9$k$3$H$NL\E*$O!"H/8@<T$rJ,$+$j$d$9(B
;;	$B$/$9$k$?$a$H!"0zMQ5-9f$,4v=E$K$b$J$C$F8+$E$i$/$J$k$N$rKI$0$3$H$G(B
;;	$B$9$+$i!"4{$K%?%0$NIU$$$F$$$kItJ,$K$5$i$K%?%0$rIU$1$k$HM>7W8+$E$i(B
;;	$B$/$J$C$F$7$^$$$^$9!#$=$l$J$iC1=c$KL>A0$rIU$1$:!V(B>$B!W$@$1$G0zMQ$7(B
;;	$B$?$[$&$,$^$7$@$H8@$($^$9!#$^$?!"6uGr9T$KL>A0IU$-%?%0$rIU$1$k$3$H(B
;;	$B$b$&$k$5$/$F8+$E$i$$$N$G(Bxcite$B$G$O9T$$$^$;$s!#>l9g$K$h$C$F$O!"C1(B
;;	$B$K!V(B>$B!WJ8;z$,$"$k$@$1$G!"4{$K0zMQ$5$l$F$$$k$o$1$G$O$J$$9T$r(Bxcite
;;	$B$,L5;k$7$F$7$^$&>l9g$,$"$j$^$9$,!"$=$N$H$-$O(B M-x xcite i $B$K$h$j(B
;;	$B<jF0$G0zMQ%?%0$rIU$1$F$/$@$5$$!#$?$@$7!"(Bxcite$B$G$b%?%0$NL>A0$r>J(B
;;	$BN,$7$F!V(B>$B!W$@$1$G0zMQ$7$?>l9g$O!"A4$F$N9T$K$b$l$J$/!V(B>$B!W$rIU$1$F(B
;;	$B0zMQ$7$^$9$N$G!"(Btraditional$B$JJ}K!$,$U$5$o$7$$>l9g$OL>A0L5$7$G0z(B
;;	$BMQ$7$F$/$@$5$$!#(B
;;
;;  * Can I incorporate this program into Debian package?
;;
;;	Yes.
;;	This  "Yes"  is  NOT  a  special answer  only  for  Debian.
;;	My  recognition  on  `free  software'  is  not  the  permanently
;;	constant  notion.  Therefore  I won't  define the  fixed license
;;	sentences at any moment of my life.  All I can say now is I hope
;;	the free  software be; freely  usable, freely (re-)distributable
;;	without  any charge  for  itself, freely  modifiable unless  the
;;	original  author(=me)'s copyrights  are infringed  or neglected,
;;	absolutely not responsible to  any result from itself.  If there
;;	is A  license clauses which  implies these points above  in some
;;	era, this  software can  be classified into  the group  that the
;;	clauses want to assume as `free'.
;;
;;[Customization]
;;
;;  * xcite:insert-header-function
;;
;;	The function    which produces citation    header.  The  default
;;	function is `xcite-default-header'.  Consult this function as an
;;	example.  Define   your favorite function and  set   the name of
;;	function to this variable.  If  you make a function named `foo',
;;	(setq xcite:insert-header-function 'foo).
;;
;;	$B0zMQ$N@hF,$N%X%C%@$H$J$kJ8;zNs$r@8@.$9$k4X?t!#%G%U%)%k%H$N4X?t$N(B
;;	xcite-default-header $B$r;29M$K$7$F2<$5$$!#FH<+$N4X?t$rNc$($P(B foo
;;	$B$H$$$&L>A0$GDj5A$7$?$i!"(B(setq xcite:insert-header-function 'foo)
;;	$B$H$7$F$/$@$5$$!#(B
;;
;;  * xcite:cite-hook
;;
;;	The hook function which is called when the article has just been
;;	cited with prefix.  When the hook  function is called, buffer is
;;	narrowed from the beginning of the cited text to the its end.
;;
;;	$BH/8@$r0zMQ$7$?$"$H$K!"0zMQItJ,A4BN$KBP$7$FF/$/%U%C%/4X?t!#$3$N4X(B
;;	$B?t$,8F$P$l$k;~$O!"$=$N%P%C%U%!$,0zMQ3+;O0LCV$+$i=*N;0LCV$^$G$N%j(B
;;	$B%8%g%s$K(Bnarrowing$B$5$l$F$$$^$9!#(B
;;
;;	$B$A$J$_$K:n<T$O!"<+J,$N5-;v$r!V9-@%$5$s(B>$B!W$H7I>NIU$-$G0zMQ$5$l$k(B
;;	$B$N$,9%$-$G$J$$$N$G!"$3$N(Bhook$B$G!V$5$s!W$r<h$j=|$$$F$$$^$9!#$5$i$K!"(B
;;	$B4A;z$N!V!d!W$G0zMQ$7$FMh$??M$NJ8>O$N0zMQ%?%0$r<h$j=|$$$F$$$^$9!#(B
;;	$B@_Dj$O0J2<$N$h$&$K$J$j$^$9!#(B
;;
;;		;; $B!V$f$&$8$5$s(B>$B!W$r(B $B!V$f(B>$B!W$K!"(B
;;		;; $B!V9-@%$5$s(B>$B!W!V9-@%;a(B>$B!W$r(B $B!V9-(B>$B!W$KJQ$($k(B
;;		(setq xcite:cite-hook
;;		      '(lambda ()
;;			 (goto-char (point-min))
;;			 (replace-regexp "^$B$f$&$8$5$s(B>" "$B$f(B>")
;;			 (goto-char (point-min))
;;			 (replace-regexp "^$B9-@%(B\\($B$5$s(B\\|$B;a(B\\)>" "$B9-(B>")
;;			 (goto-char (point-min))
;;			 (replace-regexp
;;			 (concat "^" xcite:current-citation-prefix "$B!d(B") ">")))
;;
;;  * xcite:toggle-ask-citation-default
;;
;;	The default action of xcite.el is to select a citation header at
;;	random.  If you want xcite to ask a header, set this variable to
;;	t.  If t,  xcite asks  normally and   select randomly  with  C-u
;;	prefix.
;;
;;	$BDL>o$O!"!V%G%U%)%k%H$G%i%s%@%`$G0zMQ%?%0$r7h$a$F!"(BC-u$B$rIU$1$F4X(B
;;	$B?t$r5/F0$9$k$HJ9$$$FMh$k!W$G$9$,!"$3$l$rH?E>$7$^$9!#(B
;;
;;  * xcite:mail-buffer-identifier
;;
;;	By   default, xcite detects   the    mail displaying buffer   by
;;	searching  the `Subject:' field.   This variables alters it.  If
;;	you want  to check the mail buffer   by `Date:' field,  set this
;;	variable to "^Date:".
;;
;;	xcite$B$O%G%U%)%k%H$G%a%$%k%P%C%U%!$G$"$k$3$H$N3NG'$r!V(BSubject:$B!W(B
;;	$B%U%#!<%k%I$rC5$7$F9T$$$^$9!#$3$l$rJL$N%U%#!<%k%I$KJQ99$7$^$9!#(B
;;	$B!V(BDate:$B!W%U%#!<%k%I$G3NG'$5$;$?$$;~$O!"$3$NJQ?t$r(B "^Date:" $B$H$7(B
;;	$B$^$9!#(B
;;
;;  * xcite:citation-table
;;
;;	The file name in which xcite stores citation name vs. its
;;	author.  Default value is `~/.xciterc'.
;;
;;	$BCx<T$H0zMQ%?%0$NBP1~I=$rJ]B8$9$k%U%!%$%kL>!#%G%U%)%k%HCM$O(B
;;	"~/.xciterc"$B!#(B
;;
;;  * xcite:minibuf-ease-C-k
;;
;;	When  reading citation  prefix  in the  minibuffer, set  initial
;;	point at  the begining of  default string(this is easy  to erase
;;	string  by C-k).   The defualt  value is  yes(non-nil).   If you
;;	prefer the initial position being at the end of string, set this
;;	to nil.
;;
;;	$B%_%K%P%C%U%!$G$N0zMQ%?%0$NF~NO;~$K!"%+!<%=%k0LCV$r@hF,$KCV$/$+(B
;;	($B@hF,$KCV$/$H(BC-k$B$G>C$7$d$9$$(B)$B!#KvHx$KCV$-$?$$$H$-$O$3$NJQ?t$r(Bnil
;;	$B$K$9$k!#(B
;;
;;[Acknowledgements]
;;
;;	$B$^$:7K@nD>8J7/$K46<U$7$^$9!#H`$J$/$7$F$O(Bxcite$B$O@8$^$l$J$+$C$?$G(B
;;	$B$7$g$&!#(BASCII NET$B$G%3%m%3%m$H%O%s%I%k$rJQ$($k$N$G!"0zMQ%?%0$r$?(B
;;	$B$/$5$s@ZBX$($?$$$H$$$&F05!$,@8$^$l$^$7$?!#(Bxcite$B$r(Bfj$B$K8xI=$7$F46(B
;;	$B<U$N0U$rEA$($F4V$b$J$$(B1997$BG/(B3$B7n(B10$BF|!"H`$O8rDL;v8N$K$h$j(B26$B:P$G$3(B
;;	$B$N@$$r5n$j$^$7$?!#(Bxcite$B$r;H$&$H$-$K!"$=$N$-$C$+$1$r:n$C$?H`$N8f(B
;;	$BL=J!$r5'G0$7$FD:$1$l$P9,$$$G$9!#H`$,;D$7$?%O%s%I%k$N$$$/$D$+$r!"(B
;;	xciterc$B7A<0$G(B http://www.gentei.org/~yuuji/lune/handles
;;	$B$KCV$-$^$9!#(B
;;
;;	sc-register$B$N:n<T$G$"$j!";d$K(B Emacs-Lisp$B$r65$($F$/$@$5$C$?W"@%M[(B
;;	$B0l$5$s$K46<U$7$^$9!#$d$O$j(Bsc-register$B$NB8:_$,$J$+$C$?$i(Bxcite$B$bB8(B
;;	$B:_$7$F$$$J$+$C$?$G$7$g$&!#5{$,$7$K$F!V:#$O(Bxcite$B;H$C$F$k$h!W$HJ9(B
;;	$B$$$?$3$H$O;jJ!$N4n$S$G$9!#(B
;;
;;	$B$=$7$F(Bxcite$B$N%G%P%C%0$d%A%e!<%s$K6(NO$7$F$/$@$5$C$?0J2<$N3'$5$s(B
;;	$B$K46<U$7$^$9!#(B
;;	$B!&L}C+N5;VO:$5$s(B(asciinet)
;;	$B!&OBED7<Fs$5$s(B($B2#IM9qBg(B)
;;	$B!&@DLZ><M:$5$s(B($B%"%k%U%!%7%9%F%`%:(B)
;;	$B!&5\:j?8$5$s(B($B6e=#Bg(B)
;;	$B!&550fC#Li$5$s(B($BEl9)Bg(B)
;;	$B!&2#EDOBLi$5$s(B($B%^%D%@(B)
;;	$B!&74;3D>Bg$5$s(B($BF|K\Am9g%7%9%F%`(B)
;;	$B!&?9@n=$$5$s(B(NTT$B%3%`%&%'%"(B)
;;	$B!&Gr0f=(9T$5$s(B($B>>2<EEAw%7%9%F%`(B)
;;	$B!&EZ202mL-$5$s(B($B5~ETBg3X(B)
;;	$B!&?7F20B9'$5$s(B($BBg:e;TN)Bg3X(B)
;;
;;[Disclaimer]
;;
;;	This  software  is distributed as  a free  software  without any
;;	warranty to anything  as a result  of using this.  Especially, I
;;	am not responsible for the case when you cite your friend's mail
;;	with a silly citation prefix in a serious situation :)
;;
;;	The pronunciation of xcite is the same as excite.
;;
;;	$B$3$N%W%m%0%i%`$O%U%j!<%=%U%H%&%'%"$G$9!#$3$N%W%m%0%i%`$rMQ$$$?7k(B
;;	$B2L$KBP$9$kJ]>Z$O0l@ZIi$$$^$;$s$N$G$4Cm0U2<$5$$!#$H$/$K!"M'?M$NH/(B
;;	$B8@$r$*4VH4$1$J%?%0$G0zMQ$7$?$b$N$r!"(Bfj$B$K=P$7$F$7$^$C$?$j$7$F$b;d(B
;;	$B$O4XCN$7$^$;$s(B($B>P(B)$B!#$^$?!"(Bxcite$B$O$$$8$k5$NO$,$9$0$K$J$/$J$k4m81(B
;;	$B@-$,9b$$$N$G!";H$C$F$_$FMWK>$J$I$,$"$k$H$-$OAa$a$K:n<T$K8@$C$F2<(B
;;	$B$5$$(B:-)$B!#4{$K2??M$+$N?M$K;H$C$F$b$i$C$F!"3F?M$N9%$_$N@^Co$K$J$k(B
;;	$B$h$&%A%e!<%s$7$F$"$k$N$G!":NMQ$5$l$J$$MWK>$b$"$k$+$H;W$$$^$9$,!"(B
;;	$B??7u$KBP1~$7$^$9$N$G8f1sN8L5$7$K$I$&$>!#(B
;;
;;	xcite$B$O(Bexcite$B$HF1$8H/2;$GFI$s$G$/$@$5$$!#(B
;;
;;				Jul. 2001 $B9-@%M:Fs(B [yuuji@gentei.org]
;;

;;;
;; Exciting cite for Mule
;;;
(defvar xcite:author-type-n "^Author: \\([a-z][a-z][a-z][0-9]+\\) (\\(.*\\))$")
(defvar xcite:author-mail   "^From: \\([a-z][a-z][a-z][-0-9].+\\) (\\(.*\\))$")
(defvar xcite:author-inet   "^From: \\(.*\\S \\)? *<\\(.*\\)>$")
(defvar xcite:author-news   "^From: \\(.*\\S \\) *(\\(.*\\))$")
(defvar xcite:author-vague  "^From: \\(.*\\)$")
(defvar xcite:mail-stamp
  (concat
   "^From \\([a-z][a-z][a-z][0-9]+\\) "		;ID(1)
   "\\([A-Z][a-z][a-z]\\) "			;day of week(2)
   "\\([A-Z][a-z][a-z]\\) *"			;month(3)
   "\\([0-9][0-9]*\\) *"			;day of month(4)
   "\\([0-9][0-9]*\\):\\([0-9][0-9]\\):\\([0-9][0-9]\\) *" ;hh(5):mm(6):ss(7)
   "\\([0-9][0-9][0-9][0-9]\\)"			;year(8)
   ))
(defvar xcite:inet-date "^Date: \\(.*\\)$")
(defvar xcite:inet-msgid	"^Message-Id: \\(<.*>\\)")
(defvar xcite:inet-subject "^Subject: \\(.+\\)$")
(defvar xcite:inet-ng "^Newsgroups: \\(.+\\)$")

(defvar xcite:author-regexp
  (concat
   xcite:author-type-n	"\\|"
   xcite:author-mail	"\\|"
   xcite:author-inet	"\\|"
   xcite:author-news	"\\|"
   xcite:author-vague)
  "Regexp of author header")

(defvar xcite-handle-alphabets "[-a-zA-Z0-9'@_()$B!<!!(B-$Bs~(B]"
  "*List of characters that can be used for handle")
(defvar xcite:toggle-ask-citation-default nil
  "*Non-nil means toggle whether xcite asks the citation prefix.
Normally xcite asks the prefix and C-u for xcite determines randomly,
Non-nil for this variable toggles it.")
(defvar xcite:mail-buffer-identifier "^Subject:"
  "*Use this regexp for searching mail buffer which will be cited.")
(defvar xcite:x-cite t)
(defvar xcite:minibuf-ease-C-k t
  "*Non-nil for putting point at the beginning of default citation.")

(defvar xcite-cite-regexp
  (concat
   "^>+[ \t]*\\|"
   "^\\(" xcite-handle-alphabets "\\|[ \t]\\)*" xcite-handle-alphabets ;;"\\)"
   ">+[ \t]*")
  "*Regexp of string which is regarded that it has been already cited.")

(defvar xcite:insert-header-function 'xcite-default-header
  "$B0zMQ$N@hF,$K$D$1$kJ8;zNs$r@8@.$9$k4X?t$NL>A0!#(B
$B$=$N4X?tCf$G$O(B id, author, date, time, year, month, day, hour, minute, ampm,
tag $B$H$$$&JQ?t$rMxMQ$9$k$3$H$,$G$-$k!#$?$@$7!"(BInternet $B$G$N(B Mail $B$G$O(B
date, id(e-mail $B%"%I%l%9(B), handle($B<BL>%U%#!<%k%I(B), msgid(Message-ID),
subject, tag($B0zMQ%?%0(B), ng(NetNews$B$N>l9g$N(BNewsgroups)$B$,MxMQ2DG=(B.")

(defvar xcite:default-user-prefix-alist
  '(("yuuji@ae.keio.ac.jp" "$B$f(B" "$B9-(B")
    ("yuuji@gentei.org" "$B$f(B" "$B9-(B")
    ("yokota.k@lab.mazda.co.jp" "$B2#ED(B")
    ("yokota-k@venus.dtinet.or.jp" "$B$+(B")
    ("morikawa.osamu@d70.node.nttcom.co.jp" "$B?9(B"))
  ".xciterc $B$KL5$$$H$-$KMQ$$$i$l$kFCJL$J%f!<%60zMQJ8;zNs$N%j%9%H(B")

(defun xcite-default-header ()
  "$B%G%U%)%k%H$N0zMQ%X%C%@J8;zNs@8@.4X?t(B."
  (if (string-match "jp$" id)
      (format ">>> %s $B$N9o$K(B%s\n>>> %s%s$B;a[)$/(B\n"
	      date
	      (if (string< "" tag) (concat " $B!V(B" tag "$B!W!"$9$J$o$A(B") "")
	      id (if handle (concat "(" handle ") ") ""))
    (format ">>>>> On %s\n>>>>> %s%s said:\n"
	    date (or id "") (if handle (concat "(" handle ") ") ""))))



;(defvar xcite:single-article-modes
;  '(mh-show-mode gnus-article-mode mew-message-mode)
;  "*Major modes of which buffers have contain single article;
;If article buffer is in such modes, Xcite searches the author from
;the beginning of the buffer.")
(defvar xcite:multiple-article-modes
  '(anmode)
  "*Major modes of which buffers have contain multiple article;
If article buffer is in such modes, Xcite searches the author from point.")

(defvar xcite:citation-table
  (if (eq system-type 'ms-dos) "~/_xciterc" "~/.xciterc"))
(defvar xcite:citation-suffix "> "
  "*Citation suffix of each tag.  The default value is \"> \".")
(defvar xcite:citation-leader nil
  "*Citation leader of each tag.  The default value is nil.
This string should consist of characters listed in xcite-handle-alphabets.
If you got reset the value of xcite:citation-leader, try to change the
string to more orthodox one.")
(defvar xcite:current-citation-prefix nil
  "Holds the current citation prefix.")

(defvar xcite:get-article-buffer-function nil
  "*User defined function to get mail/news article buffer.
This function should return the buffer object if it found article buffer.
And return nil if not.")

(defvar xcite:paragraph-separate
  (concat paragraph-separate "\\|"
	  xcite:author-regexp))
(defvar xcite:citation-map nil)
(defvar xcite:first-second-preson
  "^\\($B;d(B\\|[$B$"$o(B]$B$?$/(B?$B$7(B\\|$BKM(B\\|$B$\$/(B\\($B$A$s(B\\)?\\|$B26(B\\|$B$*$l(B\\|me\\|$B$o$7(B\\|$B$"$C$7(B\\|$B$*$$$i(B\\|$B@[<T(B?\\|$B<+J,(B\\|$B8J(B\\|$BD?(B\\|$BM>(B\\|$B$"$J$?(B\\|$B7/(B\\|$B$*$^$((B\\|[$B$-$A(B]$B$_(B\\|$B>.@8(B\\|$B2fGZ(B?\\)$"
  "Regexp of the first or second person.")

(if xcite:citation-map nil
  (setq xcite:citation-map (copy-keymap global-map))
  (define-key xcite:citation-map "n"	'xcite-next-line)
  (define-key xcite:citation-map "p"	'xcite-prev-line)
  (define-key xcite:citation-map "v"	'xcite-scroll-up)
  (define-key xcite:citation-map "V"	'xcite-scroll-down)
  (define-key xcite:citation-map " "	'exit-recursive-edit)
  (define-key xcite:citation-map "\^M"	'exit-recursive-edit)
  (define-key xcite:citation-map "q"	'abort-recursive-edit)
  (define-key xcite:citation-map "\^G"	'abort-recursive-edit))
(defvar xcite:cite-message
  "`N' for next-line, `P' for prev-line, RET or SPC for select, Q for quit")

(defun xcite-next-line (arg)
  (interactive "p") (next-line arg) (message xcite:cite-message))
(defun xcite-prev-line (arg)
  (interactive "p") (xcite-next-line (- arg)))
(defun xcite-scroll-up (arg)
  (interactive "p") (scroll-up arg) (message xcite:cite-message))
(defun xcite-scroll-down (arg)
  (interactive "p") (xcite-scroll-up (- arg)))

(defun xcite (arg)
  "sc-regs.def clone for Mule."
  (interactive "P")
  (message "Y)ank W)copy A)ppend P)repend I)nsertPrefix R)egionCite Q)fill")
  (let ((c (downcase (read-char))))
    (cond
     ((= c ?y) (xcite-yank-cur-msg arg))
     ((= c ?w) (let ((xcite:get-article-buffer-function 'current-buffer))
		 (xcite-cite t nil nil arg)))
     ((= c ?a) (let ((xcite:get-article-buffer-function 'current-buffer))
		 (xcite-cite 'append nil nil arg)))
     ((= c ?p) (let ((xcite:get-article-buffer-function 'current-buffer))
		 (xcite-cite 'prepend nil nil arg)))
     ((= c ?i) (xcite/prefix))
     ((= c ?r) (xcite/prefix-region (region-beginning) (region-end)))
     ((= c ?q) (xcite-fill arg)))))

(defun xcite/tr-string (str from to)
  (let ((str (copy-sequence str))(i 0) (len (length str)))
    (while (< i len)
      (if (= (aref str i) from)
	  (aset str i to))
      (setq i (1+ i)))
    str))

(defun xcite/id2prefix (id &optional default ask special)
  "Return the citation prefix for ID with query.
Optional 2nd argument DEFAULT is used as default prefix.
3rd argument RANDOM determines citation prefix at random.
4th argumetn SPECIAL specifies the special default prefix."
  (let (prefix abort (plist (if special (list (list special))))
	default-alist candidates m (random (not ask)))
    (if xcite:toggle-ask-citation-default
	(setq random (not random)))
    (save-excursion
      ;;(if default (xcite/tr-string default ? ?_))
      (set-buffer (find-file-noselect xcite:citation-table))
      (goto-char (point-min))
      (if (and (re-search-forward (concat "^" (regexp-quote id) "\\s ") nil t)
	       (progn
		 (skip-chars-forward " \t")
		 (not (eolp))))
	  ;;return value
	  (save-restriction
	    (save-excursion
	      (narrow-to-region (point) (progn (forward-line 1) (point)))
	      (goto-char (point-min))
	      (while (re-search-forward "\\([!-z$B!!(B-$Bs~(B]+\\)\\s *" nil t)
		(setq plist
		      (cons (list (xcite/tr-string (xcite-match-string 1) ?_ ? ))
			    plist))))))
      (while (and default (string< "" default))
	(setq default-alist
	      (cons
	       (list
		(substring
		 default 0
		 (setq m (string-match
			  "\\(\"\\|\\s \\|\\s(\\|\\s)\\)+" default))))
	       default-alist))
	(if m (setq default (substring default (match-end 0)))
	  (setq default nil)))
      (and (null plist)		;Special users' prefix
	   (assoc id xcite:default-user-prefix-alist)
	   (setq plist ;convert to alist
		 (mapcar (function (lambda (e) (list e)))
			 (cdr (assoc id xcite:default-user-prefix-alist)))))
      (or (assoc (substring id 0 (string-match "@" id)) plist)
	  (setq default-alist
		(cons (list (substring id 0 (string-match "@" id)))
		      default-alist)))
      (setq candidates (append (setq plist (reverse plist))
			       default-alist))
      (if (bobp)
	  (progn (goto-char (point-max))
		 (if (not (bolp)) (newline 1))))
      (unwind-protect
	  (if (and random (> (length plist) 0))
	      (setq prefix
		    (car (nth (random (length plist)) plist)))
	    (let*((minibuffer-completion-table candidates)
		  (map minibuffer-selection-complete-map)
		  (language (downcase current-language-environment))
		  (upkey (key-description
			  (car (where-is-internal
				'previous-history-element map))))
		  (dnkey (key-description
			  (car (where-is-internal
				'next-history-element map))))
		  (kill-ring kill-ring));preserve kill-ring
	      (setq random nil)		;turns to flag
	      (while (null prefix)
		(setq prefix
		      (read-from-minibuffer
		       (format "%s(%s/%s): "
			       (cond
				((string-match "japan" language)
				 "$B0zMQL>(B")
				((string-match "^chin" language)
				 "Citation Name")
				(t "Citation Name"))
			       (or upkey "C-p") (or dnkey "C-n"))
		       (if (and (string< "19" emacs-version)
				xcite:minibuf-ease-C-k)
			   (cons (car (car candidates))
				 (if (string< "20" emacs-version) 0 1))
			 (car (car candidates)))
		       minibuffer-selection-complete-map))
		(if (string-match xcite:first-second-preson prefix)
		    (progn
		      (ding)
		      (message "$B0l!&Fs?M>N$G0zMQ$7$A$c%@%a(B")
		      (sit-for 2)
		      (setq prefix nil))))))
	(if (or (null prefix)
		(string= prefix "")
		(assoc prefix default-alist)
		(equal prefix (car (car plist)))
		random
		(not (y-or-n-p (concat prefix " $B$rEPO?$7$^$9$+(B?"))))
	    nil
	  (if (assoc prefix plist)
	      (setq plist		;move current choice to the top
		    (cons (list prefix)
			  (delete-member (list prefix) plist)))
	    ;;(setq plist (cons (list prefix) candidates))
	    (setq plist (cons (list prefix) plist)))
	  (delete-region
	   (progn (beginning-of-line) (point))
	   (progn (forward-line 1) (point)))
	  (insert (format "%s\t%s\n" id
			  (mapconcat
			   (function
			    (lambda (s) (xcite/tr-string (car s) ? ?_)))
			   plist " ")))
	  (beginning-of-line)
	  (delete-blank-lines)))
      (basic-save-buffer)
      (kill-buffer nil)
      prefix)))

;;;
;; Minibuffer selection map
;;;
(defvar minibuffer-selection-complete-map nil)
(if minibuffer-selection-complete-map nil
  (setq minibuffer-selection-complete-map
	(copy-keymap minibuffer-local-completion-map))
  (define-key minibuffer-selection-complete-map "\C-p"
    'minibuffer-selection-previous)
  (define-key minibuffer-selection-complete-map "\C-e"
    'minibuffer-selection-previous)
  (define-key minibuffer-selection-complete-map "\C-n"
    'minibuffer-selection-forward)
  (if (eq (key-binding " ") 'mlh-space-bar-backward-henkan)
      (define-key minibuffer-selection-complete-map " " nil))
  (if (string= (getenv "USER") "yuuji")
      (define-key minibuffer-selection-complete-map "\C-x"
	'minibuffer-selection-forward)))

(defun minibuffer-selection-forward (arg)
  "Move to next candidate."
  (interactive "p")
  (let ((list minibuffer-completion-table)
	(current (if (fboundp 'field-string)
		     (field-string (point-max))
		   (buffer-string)))
	(i 0))
    (while list
      (if (string= current (car (car list)))
	  (setq list nil)
	(setq i (1+ i) list (cdr list))))
    (setq i (max (min (+ i arg) (1- (length minibuffer-completion-table))) 0))
    (if (fboundp 'delete-field) (delete-field) (erase-buffer))
    (funcall
     (if xcite:minibuf-ease-C-k
	 (function (lambda (s) (save-excursion (insert s))))
       'insert)
     (car (nth i minibuffer-completion-table)))))

(defun minibuffer-selection-previous (arg)
  "Move to previous candidate."
  (interactive "p")
  (minibuffer-selection-forward (- arg)))



(defun xcite-cite (&optional noyank beg end ask buffer)
  "Cite from other buffer.  If NOYANK is non-nil, do not paste the text.
Optional 3rd and 4th argument BEG, END specify the region to cite,
5th argument ASK decides the citation header with query.
BUFFER is the buffer where cited text belongs.
This function should be called from the buffer to which yank-contents
should go."
  (interactive "P")
  (let ((sw (selected-window)) (b (make-marker)) (e (make-marker))
	(cb (current-buffer)) (p (point))
	mesg n id handle date time year month day hour minute ampm msgid tag
	subject ng peoh x-cite-me zmacs-regions
	(tmpbuf " *xcite tmp*"))
    (save-excursion
      (cond
       (noyank nil)
       ((and buffer (get-buffer buffer))
	(set-buffer (get-buffer buffer)))
       ((one-window-p) (switch-to-buffer nil))
       (t (xcite-goto-article-window)))
      (cond
       (beg
	(goto-char (min beg end))
	(setq b (point-marker))
	(goto-char (max beg end))
	(setq e (point-marker)))
       (t
	(set-marker b (region-beginning))
	(set-marker e (region-end))))
      (if (not (eq (marker-buffer b) (marker-buffer e)))
	  (error "$B$=$$$D$!$G$-$J$$AjCL$@(B"))
      (set-buffer (marker-buffer b))
      (setq mesg (xcite-buffer-substring
		  (marker-position b) (marker-position e)))
      (if (null
	   (cond ((memq major-mode xcite:multiple-article-modes)
		  (goto-char (point-min))
		  (re-search-forward "^$" nil 1)
		  (re-search-backward xcite:author-regexp nil t))
		 (t (let (hend)
		      (goto-char (point-min))
		      (re-search-forward "^$" nil 1)
		      (setq hend (point))
		      (goto-char (point-min))
		      (if (re-search-forward xcite:author-regexp hend t)
			  (goto-char (match-beginning 0)))))))
	  (error "Can't detect the author of this article."))
      (cond
       ((and (boundp 'an:note-stamp) (looking-at an:note-stamp))
	(setq hour	(xcite-match-string 1)
	      minute	(xcite-match-string 2)
	      ampm	(xcite-match-string 3)
	      month	(xcite-match-string 4)
	      day	(xcite-match-string 5)
	      year	(xcite-match-string 6)
	      date	(xcite-match-string 4 6)
	      time	(xcite-match-string 1 3)
	      id	(xcite-match-string 7)
	      handle	(xcite-match-string 8)))
       ((looking-at xcite:author-type-n)
	(setq id	(xcite-match-string 1)
	      handle	(xcite-match-string 2)))
       ((or (and (looking-at xcite:author-inet)
		 (setq id	(xcite-match-string 2)
		       handle	(or (xcite-match-string 1)
				    (xcite-match-string 2))))
	    (and (looking-at xcite:author-news)
		 (setq id	(xcite-match-string 1)
		       handle	(xcite-match-string 2)))
	    (and (looking-at xcite:author-vague)
		 (setq handle	nil ;"$BL>L5$7$N8"J<1R(B"
		       id	(xcite-match-string 1))))
	(save-excursion
	  (re-search-forward "^$" nil t)
	  (setq peoh (point))		;remark point of end of header
	  (if (re-search-backward xcite:inet-date nil 1)
	      (setq date (xcite-match-string 1)))
	  (goto-char peoh)
	  (if (re-search-backward xcite:inet-msgid nil 1)
	      (setq msgid (xcite-match-string 1)))
	  (goto-char peoh)
	  (if (re-search-backward xcite:inet-ng nil 1)
	      (setq ng (xcite-match-string 1)))
	  (goto-char peoh)
	  (if (re-search-backward xcite:inet-subject nil t)
	      (setq subject (xcite-match-string 1))))
	)
       ((looking-at xcite:author-mail)
	(setq id	(xcite-match-string 1)
	      handle	(xcite-match-string 2))
	(save-excursion (re-search-backward xcite:mail-stamp))
	(setq month	(xcite-match-string 3)
	      day	(xcite-match-string 4)
	      hour	(xcite-match-string 5)
	      minute	(xcite-match-string 6)
	      year	(xcite-match-string 8)))
       );cond
      );;return from excursion
    (select-or-switch-to-buffer cb)	;return to current buffer
    (make-local-variable 'xcite:current-citation-prefix)
    (or (null xcite:citation-leader)
	(string-match
	 xcite-cite-regexp
	 (concat xcite:citation-leader "x" xcite:citation-suffix))
	(setq xcite:citation-leader nil))
    (setq x-cite-me (or (xcite-get-field "X-cite-me:")
			(xcite-get-field "X-attribution:")))
    (setq tag (or (and (not ask) x-cite-me)
		  (xcite/id2prefix id handle ask x-cite-me))
	  xcite:current-citation-prefix
	  (concat xcite:citation-leader tag xcite:citation-suffix))
    (save-excursion			;save-excursion again
      (if noyank
	  (let ((prefix xcite:current-citation-prefix))
	    (set-buffer (get-buffer-create tmpbuf))
	    (setq xcite:current-citation-prefix prefix) ;buffer-local
	    (erase-buffer)
	    (setq p (point))
	    (insert ?\n)))
      (setq b (point-marker))
      (if (fboundp 'insert-and-inherit)
	  (insert-and-inherit mesg)
	(insert-after-markers mesg))
      (setq e (point-marker))
      (goto-char b)
      (while (< (point) (marker-position e))
	(beginning-of-line)
	(if (or (string= xcite:current-citation-prefix xcite:citation-suffix)
		(not (or (looking-at xcite-cite-regexp)
			 ;; (looking-at xcite:paragraph-separate)
			 ;;(looking-at paragraph-separate) ;removed 1.45
			 (looking-at "^\\|$")
			 )))
	    (insert xcite:current-citation-prefix))
	(forward-line 1))
      (save-restriction
	(narrow-to-region b e)
	(run-hooks 'xcite:cite-hook))
      (if (and xcite:insert-header-function
	       (fboundp xcite:insert-header-function))
	  (progn
	    (goto-char p)
	    ;(newline 1)
	    (insert (funcall xcite:insert-header-function))
	    (goto-char p)))
      (if noyank
	  (progn (cond
		  ((eq noyank 'append) (kill-append (buffer-string) nil))
		  ((eq noyank 'prepend) (kill-append (buffer-string) t))
		  (t (copy-region-as-kill (point-min) (point-max))))
		 (kill-buffer tmpbuf))
	;; Hack X-Mailer header (only in yank mode)
	(cond
	 (xcite:x-cite
	  (goto-char (point-min))
	  (cond
	   ((re-search-forward
	    "^\\(X-\\(Mailer\\|Newsreader\\|cite\\)\\|User-agent\\): " b t)
	    (goto-char (match-end 0))
	    (or (looking-at "xcite")
		(insert "xcite" xcite:version "> ")))
	   (t (if (re-search-forward "^Subject: " b t)
		  (re-search-forward "^\\S " b 1))
	      (beginning-of-line)
	      (save-excursion (insert ?\n))
	      (if (pos-visible-in-window-p)
		  (let ((p (point)))
		    (if (fboundp 'original-scroll-up)
			(original-scroll-up 1)
		      (scroll-up 1))
		    (goto-char p)))
	      (insert "X-cite: xcite " xcite:version)))))))))

(defun xcite/prefix ()
  (if (and xcite:current-citation-prefix
	   (stringp xcite:current-citation-prefix))
      (save-excursion
	(beginning-of-line)
	(insert xcite:current-citation-prefix))))

(defun xcite/prefix-region (s e)
  (if (and xcite:current-citation-prefix
	   (stringp xcite:current-citation-prefix))
      (save-excursion
	(save-restriction
	  (narrow-to-region s e)
	  (goto-char s)
	  (while (not (eobp))
	    (xcite/prefix)
	    (forward-line 1))))))

(defun xcite-make-reply ()
  "Make a reply to current buffer article."
  (let (beg)
    (save-excursion
      (goto-char (point-min))
      (re-search-forward "^$")
      (setq beg (point))
      ())))

(defun xcite-yank-cur-msg (&optional arg)
  "Yank current message with citation prefix.
Non-nil for optional argument ARG selects citation prefix randomly."
  (interactive "P")
  (let (beg end b)
    (save-window-excursion
      (run-hooks 'xcite:pre-cite-hook)
      ;;(other-window 1)
      (xcite-goto-article-window)
      (setq b (current-buffer))
      (save-excursion
	(or (and (re-search-forward "^$" nil t)
		 (re-search-backward "^From:" nil t))
	    (progn
	      (goto-char (point-min))
	      (or (re-search-forward "^From:" nil t)))
	    (error "This buffer doesn't seem to be a mail buffer."))
	(re-search-forward "^$")
	(setq beg (point))
	(if (or (re-search-forward "^begin [0-9][0-9][0-9] " nil t)
		;(re-search-forward "^#!/bin/sh" nil t)
		;;/bin/sh excluded 2002/5/30
		)
	    (setq end (progn (forward-line 1) (point)))
	  (setq end (point-max)))))
    (xcite-cite nil beg end arg b)))

(defun xcite-indent-citation ()
  "Alternative function of `message-indent-citation'."
  (let ((cur-buf (current-buffer))
	(tmp-buf (generate-new-buffer " *xcite-indent-citation*")))
    (unwind-protect
	(let ((start (point))
	      (end (mark t)))
	  (set-buffer tmp-buf)
	  (insert-buffer-substring cur-buf start end)
	  (goto-char (point-min))
	  (set-buffer cur-buf)
	  (delete-region start end)
	  (let ((xcite:get-article-buffer-function (lambda () tmp-buf)))
	    (call-interactively 'xcite-yank-cur-msg)))
      (set-buffer cur-buf)
      (kill-buffer tmp-buf))))


(defun xcite-goto-article-window ()
  "Go to mail/news article window"
  (let ((curw (selected-window)) b)
    (or
     (and xcite:get-article-buffer-function
	  (setq b (funcall xcite:get-article-buffer-function))
	  (set-buffer b))
     (and (eq major-mode 'mew-draft-mode) ;Support mew
	  (fboundp 'mew-cache-hit) (fboundp 'mew-buffer-message)
	  (save-excursion
	    (set-buffer (get-buffer-create (mew-buffer-message)))
	    (> (buffer-size) 8))
	  (let ((mew-cite-hook '(lambda ())))
	    (set-buffer (get-buffer-create " *xcite tmp*"))
	    (erase-buffer)
	    (condition-case err
		(mew-draft-cite nil t)
	      (error (mew-draft-cite nil)))
	    (setq major-mode 'mew-message-mode)
	    t))
     (catch 'found
       (while (not (eq (select-window (next-window)) curw))
	 (if (save-excursion
	       (goto-char (point-min))
	       (re-search-forward xcite:mail-buffer-identifier nil t))
	     (throw 'found t))))
     (let ((list (cdr (buffer-list))))
       (catch 'found
	 (while list
	   (set-buffer (car list))
	   (or (string-match "^ " (buffer-name))
	       (if (save-excursion
		     (goto-char (point-min))
		     (re-search-forward xcite:mail-buffer-identifier nil t))
		   (throw 'found (current-buffer))))
	   (setq list (cdr list)))))
     )))

(defun xcite-fill-base (arg)
  (if (looking-at xcite-cite-regexp)
      (let ((fill-prefix (xcite-match-string 0))
	    (paragraph-start xcite:paragraph-separate)
	    (paragraph-separate xcite:paragraph-separate))
	(fill-paragraph arg))
    (fill-paragraph arg)))

(defun xcite-fill (&optional arg)
  "Alternative function of `fill-paragraph'."
  (interactive "P")
  (save-excursion
    (if (xcite-transient-region-active-p)
	(save-restriction
	  (narrow-to-region (region-beginning) (region-end))
	  (goto-char (point-min))
	  (xcite-fill-base arg))
      (beginning-of-line)
      (xcite-fill-base arg))))

;;;
;; Global subfunctions
;;;
(if (fboundp 'buffer-substring-no-properties)
    (fset 'xcite-buffer-substring
	  (symbol-function 'buffer-substring-no-properties))
  (fset 'xcite-buffer-substring (symbol-function 'buffer-substring)))

(defun xcite-match-string (n &optional m)
  (if (match-beginning n)
      (xcite-buffer-substring
       (match-beginning n) (match-end (or m n)))
    nil))

(defun xcite-match-substring (string n &optional m)
  (if (match-beginning n)
      (substring string (match-beginning n) (match-end (or m n)))
    nil))

(defun select-or-switch-to-buffer (buffer)
  (if (get-buffer-window buffer)
      (select-window (get-buffer-window buffer))
    (switch-to-buffer buffer)))

(if (fboundp 'delete) (fset 'delete-member 'delete)
  (defun delete-member (elt list &optional all)
    "Delete ELT from LIST by side effect.
Non-nil for optional 3rd argument ALL removes all occurences of ELT."
    (let ((ptr (cdr list)) (prevp list) atom)
      (cond
       ((equal elt (car list)) (cdr list))
       (t
	(while ptr
	  (if (equal elt (car ptr))
	      (progn
		(setcdr prevp (cdr ptr))
		(or all (setq ptr nil))))
	  (setq prevp ptr ptr (cdr ptr)))
	list)))))

(defvar xcite:field-case-fold t
  "Non-nil searches header field ignoring the case.")

(defun xcite-get-field (field &optional default-value)
  "Function for user.  Get specified header from article buffer."
  (let (fptn value)
    (or (string-match ":$" field) (setq field (concat field ":")))
    (setq fptn (concat (regexp-quote field) "\\s "))
    (save-window-excursion
      (xcite-goto-article-window)
      (save-excursion
	(goto-char (point-min))
	(let ((case-fold-search xcite:field-case-fold))
	  (re-search-forward (concat "^$\\|" fptn) nil 1))
	(if (looking-at "$")
	    default-value
	  ;; Specified field exists.
	  ;(goto-char (match-end 0))
	  (skip-chars-forward " \t\n")
	  (setq value (xcite-buffer-substring
		       (point)
		       (progn (re-search-forward "^\\S \\|^$" nil 1)
			      (1- (match-beginning 0)))))
	  ;; $B2~9T$r%9%Z!<%9$KJQ49$9$Y$-$+$J$"!D(B
	  value)))))

(cond
 ((and (boundp 'transient-mark-mode) (boundp 'mark-active))
  (defun xcite-transient-region-active-p ()
    (and transient-mark-mode mark-active)))
 ((and (boundp 'zmacs-regions) (fboundp 'region-active-p))
  (defun xcite-transient-region-active-p ()
    (and zmacs-regions (region-active-p))))
 (t
  (defun xcite-transient-region-active-p ()
    nil)))

(provide 'xcite)
(defconst xcite:revision "$Revision: 1.1 $"
  "Revision number of xcite.el")
(defconst xcite:version
  (progn (string-match "\\([0-9.]+\\)" xcite:revision)
	 (xcite-match-substring xcite:revision 1)))


; Local variables:
; fill-prefix: ";;	"
; paragraph-start: "^$\\|\\|;;$"
; paragraph-separate: "^$\\|\\|;;$"
; End:
