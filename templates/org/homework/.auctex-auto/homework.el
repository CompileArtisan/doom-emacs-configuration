;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "homework"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "margin=1in") ("fontenc" "T1") ("xcolor" "usenames" "dvipsnames" "svgnames") ("tcolorbox" "many") ("listings" "") ("etoolbox" "") ("mathtools" "") ("amsthm" "") ("amssymb" "") ("amsfonts" "") ("bm" "") ("thmtools" "") ("amsmath" "") ("marginnote" "") ("sidenotes" "") ("fancyhdr" "") ("titlesec" "") ("setspace" "") ("enumitem" "") ("graphicx" "") ("svg" "") ("hyperref" "bookmarks=true") ("bookmark" "") ("mathpazo" "") ("helvet" "scaled=0.92")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "geometry"
    "fontenc"
    "xcolor"
    "tcolorbox"
    "listings"
    "etoolbox"
    "mathtools"
    "amsthm"
    "amssymb"
    "amsfonts"
    "bm"
    "thmtools"
    "amsmath"
    "marginnote"
    "sidenotes"
    "fancyhdr"
    "titlesec"
    "setspace"
    "enumitem"
    "graphicx"
    "svg"
    "hyperref"
    "bookmark"
    "mathpazo"
    "helvet")
   (TeX-add-symbols
    '("uppersum" ["argument"] 0)
    '("lowersum" ["argument"] 0)
    '("partition" ["argument"] 0)
    '("func" ["argument"] 1)
    '("cop" 1)
    '("gfcb" 1)
    '("hint" 1)
    '("set" 1)
    '("integral" 2)
    '("absld" 1)
    '("absle" 1)
    '("abs" 1)
    "eps"
    "A"
    "E"
    "N"
    "Q"
    "R"
    "Z"
    "intab"
    "fabr"
    "fog"
    "gof"
    "deltaxi"
    "deltaxk"
    "Title"
    "Author"
    "Date"
    "resetpar")
   (LaTeX-add-xcolor-definecolors
    "accent"
    "accentlight"
    "inkgray"
    "codebg"
    "codekeyword"
    "codecomment"
    "codestring"
    "codenumber"
    "coderule")
   (LaTeX-add-tcolorbox-newtcolorboxes
    '("answer" "" "" ""))
   (LaTeX-add-tcolorbox-tcbuselibraries
    "listings,skins,breakable"))
 :latex)

