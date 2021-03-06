;############################################################################
;#   Emacs config (Recommended) from Appendix C of "Perl Best Practices"    #
;#     Copyright (c) O'Reilly & Associates, 2005. All Rights Reserved.      #
;#  See: http://www.oreilly.com/pub/a/oreilly/ask_tim/2001/codepolicy.html  #
;############################################################################

;; Use cperl mode instead of the default perl mode
(defalias 'perl-mode 'cperl-mode)

;; turn autoindenting on
(global-set-key "\r" 'newline-and-indent)

;; Use 4 space indents via cperl mode
(custom-set-variables
  '(cperl-close-paren-offset -4)
   '(cperl-continued-statement-offset 4)
    '(cperl-indent-level 4)
     '(cperl-indent-parens-as-block t)
      '(cperl-tab-always-indent t))

;; Insert spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Set line width to 78 columns...
(setq fill-column 78)
(setq auto-fill-mode t)

;; Use % to match various kinds of brackets...
;; See: http://www.lifl.fr/~hodique/uploads/Perso/patches.el
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
    "Go to the matching paren if on a paren; otherwise insert %."
      (interactive "p")
        (let ((prev-char (char-to-string (preceding-char)))
	              (next-char (char-to-string (following-char))))
	      (cond ((string-match "[[{(<]" next-char) (forward-sexp 1))
		              ((string-match "[\]})>]" prev-char) (backward-sexp 1))
			                (t (self-insert-command (or arg 1))))))

;; Load an applicationtemplate in a new unattached buffer...
(defun application-template-pm ()
    "Inserts the standard Perl application template"  ; For help and info.
      (interactive "*")                                 ; Make this user accessible.
        (switch-to-buffer "application-template-pm")
	  (insert-file "~/.code_templates/perl_application.pl"))
;; Set to a specific key combination...
(global-set-key "\C-ca" 'application-template-pm)

;; Load a module template in a new unattached buffer...
(defun module-template-pm ()
    "Inserts the standard Perl module template"       ; For help and info.
      (interactive "*")                                 ; Make this user accessible.
        (switch-to-buffer "module-template-pm")
	  (insert-file "~/.code_templates/perl_module.pl"))
;; Set to a specific key combination...
(global-set-key "\C-cm" 'module-template-pm)

;; Expand the following abbreviations while typing in text files...
(abbrev-mode 1)

(define-abbrev-table 'global-abbrev-table '(
					    ("pdbg"   "use Data::Dumper qw( Dumper );\nwarn Dumper[];"   nil 1)
					    ("phbp"   "#! /usr/bin/perl -w"                              nil 1)
					    ("pbmk"   "use Benchmark qw( cmpthese );\ncmpthese -10, {};" nil 1)
					    ("pusc"   "use Smart::Comments;\n\n### "                     nil 1)
					    ("putm"   "use Test::More 'no_plan';"                        nil 1)
					    ))

(add-hook 'text-mode-hook (lambda () (abbrev-mode 1)))
