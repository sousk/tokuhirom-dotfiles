;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; w3m settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-search "w3m-search" "Search QUERY using SEARCH-ENGINE." t)
(autoload 'w3m-weather "w3m-weather" "Display weather report." t)
(autoload 'w3m-find-file "w3m" "Find a local file using emacs-w3m." t)
(autoload 'w3m-browse-url "w3m" "Ask emacs-w3m to show a URL." t)
(autoload 'w3m-antenna "w3m-antenna" "Report changes of web sites." t)
(autoload 'w3m-bookmark-view "w3m-bookmark" "Show bookmarks." t)
(autoload 'w3m-dtree "w3m-dtree" "Display a directory tree." t)
(autoload 'w3m-namazu "w3m-namazu" "Search files with Namazu." t)
(autoload 'w3m-perldoc "w3m-perldoc" "View Perl documents" t)
(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)
(setq w3m-weather-default-area "東京都・東京")

(setq w3m-add-user-agent　"Internet Explorer")

(setq w3m-command-arguments-alist
      '(
	("^http://d\\.hatena\\.ne\\.jp/tokuhirom.*"
	 "-cookie")
	("^http://d\\.hatena\\.ne\\.jp/login.*"
	 "-cookie")))

(setq w3m-command-arguments
      '("-F" "-o" "http_proxy=http://127.0.0.1:3128/"))
;;'("-F" "-cookie" "-o" "http_proxy=http://127.0.0.1:3128/"))
;;      '("-e"))
;;	     '("-F" "-cookie" "-o" "http_proxy=http://localhost:8118/")))
;;	     nil)
(setq w3m-command "w3m")
(setq w3m-use-cookies t)
(setq w3m-home-page "http://tokuhirom.tdiary.net")
(setq w3m-image-viewer "qiv")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; browse-url の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask emacs-w3m to show a URL." t)
