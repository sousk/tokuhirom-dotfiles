;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; navi2ch
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)
;(setq navi2ch-net-http-proxy "127.0.0.1:3128")
;;(setq navi2ch-net-http-proxy nil)
(setq browse-url-browser-function 'w3m-browse-url)
(setq navi2ch-mona-enable t)
(setq navi2ch-mona-enable-board-list '("mona" "aastory" "kao"))
