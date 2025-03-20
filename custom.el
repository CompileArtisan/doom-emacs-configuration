(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" default))
 '(elfeed-feeds
   '("https://www.team-bhp.com/forum/external.php?type=rss2" "http://theverge.com/rss/index.xml" "https://compileartisan.pages.dev/rss.xml" "https://adithyanair.com/rss.xml"))
 '(org-agenda-files
   '("~/OneDrive/Study Material/Semester-4/introduction to design analysis of algorithms DAA/notes/dsa1.org"))
 '(org-safe-remote-resources
   '("\\`file:///home/praaneshnair/OneDrive/Study Material/Semester-4/introduction to design analysis of algorithms DAA/notes/my-notes-on-algorithms\\.org\\'"))
 '(package-selected-packages
   '(citeproc-org elfeed org-superstar impatient-mode grip-mode))
 '(safe-local-variable-values
   '((eval add-to-list 'org-export-before-processing-hook
      (lambda
        (be)
        (org-babel-tangle)))
     (eval setq org-latex-pdf-process
      (list "latexmk -pdf %f"))
     (eval require 'doi-utils)
     (eval require 'org-ref)
     (eval ox-extras-activate
      '(ignore-headlines))
     (eval require 'ox-extra)
     (eval add-to-list 'load-path ".")))
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(org-html-head-extra "")
 '(org-latex-classes
   '(("IEEEtran" "\\documentclass[conference]{IEEEtran}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("article" "\\documentclass[11pt]{article}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("report" "\\documentclass[11pt]{report}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("book" "\\documentclass[11pt]{book}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
 '(org-latex-image-default-width "0.3\\linewidth")
 '(package-selected-packages '(org-ref)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(after! web-mode
  (add-to-list 'auto-mode-alist '("\\.astro\\'" . web-mode))
  (setq web-mode-content-types-alist '(("astro" . "\\.astro\\'")))
  (add-hook 'web-mode-hook #'lsp))
