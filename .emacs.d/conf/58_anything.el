(require 'anything-config)
(setq anything-sources (list anything-c-source-buffers
                             anything-c-source-bookmarks
                             anything-c-source-file-name-history
                             anything-c-source-man-pages
                             anything-c-source-locate
                             anything-c-source-complex-command-history))

(global-set-key "\C-xb" 'anything)
(define-key anything-map (kbd "C-M-n") 'anything-next-source)
(define-key anything-map (kbd "C-M-p") 'anything-previous-source)
(define-key anything-map (kbd "<tab>")   'anything-next-line)
(define-key anything-map (kbd "S-<tab>")   'anything-previous-line)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; anything-project
(require 'anything-project)
(global-set-key (kbd "C-c C-f") 'anything-project)
(ap:add-project
 :name 'perl
 :look-for '("Makefile.PL" "Build.PL")
 :include-regexp '("\\.pm$" "\\.t$" "\\.pl$" "\\.PL$" "\\.js$")
 ;; :exclude-regexp '("/tmp" "/blib") ; can be regexp or list of regexp
 )
