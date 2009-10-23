(require 'mmm-mode)
(setq mmm-global-mode 'maybe)
(set-face-background 'mmm-default-submode-face "#333333")

(mmm-add-classes
 '((mmm-html-css-mode
    :submode css-mode
    :face mmm-code-submode-face
    :front "<style[^>]*>\\([^<]*\\)?\n[ \t]*</style>"
    )
   (mmm-html-javascript-mode
    :submode javascript-mode
    :face mmm-code-submode-face
    :front "<script[^>]*>\\([^<]*\\)?</script>"
    :back "</script>"
    )
   (mmm-ml-css-mode
    :submode css-mode
    :face mmm-code-submode-face
    :front "<style[^>]*>"
    :back "\n?[ \t]*</style>"
    )
   (mmm-ml-javascript-mode
    :submode javascript-mode
    :face mmm-code-submode-face
    :front "<script[^>]*>[^<]"
    :front-offset -1
    :back "\n?[ \t]*</script>"
    )
   (mmm-mxml-actionscript-mode
    :submode actionscript-mode
    :face mmm-code-submode-face
    :front "<mx:Script><!\\[CDATA\\["
    :back "[ \t]*\\]\\]></mx:Script>"
    )
   ))

(mmm-add-mode-ext-class 'sgml-mode nil 'mmm-html-css-mode)
(mmm-add-mode-ext-class 'sgml-mode nil 'mmm-html-javascript-mode)
(mmm-add-mode-ext-class 'xml-mode nil 'mmm-ml-css-mode)
(mmm-add-mode-ext-class 'xml-mode nil 'mmm-ml-javascript-mode)
(mmm-add-mode-ext-class 'xml-mode nil 'mmm-mxml-actionscript-mode)