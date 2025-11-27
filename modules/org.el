;;; modules/org.el -*- lexical-binding: t; -*-

(setq org-directory "~/org/"
      org-latex-listings t)

(after! org
  (setq org-latex-src-block-backend 'listings
        org-babel-default-header-args:java '((:dir . nil) (:results . "value")))
  
  ;; Babel languages
  (org-babel-do-load-languages 'org-babel-load-languages '((java . t)))
  
  ;; Font sizes
  (set-face-attribute 'org-level-1 nil :height 1.1 :weight 'normal)
  (set-face-attribute 'org-level-2 nil :height 1.1 :weight 'normal)
  (set-face-attribute 'org-level-3 nil :height 1.1 :weight 'normal)
  (set-face-attribute 'org-document-title nil :height 1.5 :weight 'bold)
  
  ;; Markup
  (setq org-latex-text-markup-alist
        '((bold . "\\textbf{%s}")
          (code . "\\lstinline{%s}")
          (italic . "\\emph{%s}")
          (strike-through . "\\sout{%s}")
          (underline . "\\uline{%s}")
          (verbatim . "\\lstinline{%s}")))
  
  ;; Tag inheritance
  (setq org-use-tag-inheritance t))

;; Allow broken links during export
(add-hook 'org-mode-hook
          (lambda ()
            (setq org-export-with-broken-links t)))

;; Agenda
(setq org-agenda-span 45)

;; Mermaid support
(use-package! ob-mermaid)

;; org-ref
(use-package! org-ref
  :config
  (setq org-ref-default-bibliography '("~/path/to/references.bib")
        org-ref-bibliography-notes "~/path/to/notes.org"
        org-ref-pdf-directory "~/path/to/pdfs"))


