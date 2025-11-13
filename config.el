;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-




;;; Fonts & Theme

(setq doom-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 22)
      doom-big-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 34)
      doom-theme 'doom-one) ;; alt: 'catppuccin


;;; Org Mode Config
(setq TeX-command-default "xelatex")

(setq org-directory "~/org/"
      org-latex-listings t)

(after! org
  (setq org-latex-src-block-backend 'listings
        org-babel-default-header-args:java '((:dir . nil) (:results . "value")))
  (org-babel-do-load-languages 'org-babel-load-languages '((java . t)))
  (set-face-attribute 'org-level-1 nil :height 1.1 :weight 'normal)
  (set-face-attribute 'org-level-2 nil :height 1.1 :weight 'normal)
  (set-face-attribute 'org-level-3 nil :height 1.1 :weight 'normal)
  (set-face-attribute 'org-document-title nil :height 1.5 :weight 'bold)
  (setq org-latex-text-markup-alist
        '((bold . "\\textbf{%s}")
          (code . "\\lstinline{%s}")
          (italic . "\\emph{%s}")
          (strike-through . "\\sout{%s}")
          (underline . "\\uline{%s}")
          (verbatim . "\\lstinline{%s}"))))



(add-hook 'org-mode-hook
          (lambda ()
            (setq org-export-with-broken-links t)))


;;; Org Export Templates & Helpers


(defun save-and-export ()
  "Save and export current Org buffer to PDF via LaTeX."
  (interactive)
  (save-buffer)
  (org-latex-export-to-pdf))

(defun insert-org-setupfile ()
  "Insert SETUPFILE directive."
  (interactive)
  (insert "#+SETUPFILE: /home/praaneshnair/.config/doom/preamble.org\n"))

(defun insert-markdown-template ()
  "Insert YAML + Markdown structure for Org export."
  (interactive)
  (insert "#+OPTIONS: toc:nil\n#+begin_export markdown\n")
  (insert "---\ntitle: \"placeholder\"\ndate: YYYY-MM-DD\ndescription: \"placeholder\"\n---\n")
  (insert "#+end_export\n\n#+TOC: headlines 2\n"))

(defun insert-ieee-org-template ()
  "Insert IEEE-compliant Org export template."
  (interactive)
  (insert "#+TITLE: insert title here\n")
  (insert "#+SETUPFILE: /home/praaneshnair/.config/doom/ieee.org\n")
  (insert "#+LATEX_HEADER: \\input{/home/praaneshnair/.config/doom/def.tex}\n")
  (insert "#+LATEX_HEADER: \\input{/home/praaneshnair/.config/doom/author.tex}\n")
  (insert "#+LATEX_HEADER: \\graphicspath{ {.} }\n")
  (insert "#+OPTIONS: toc:nil ^:{} author:nil date:nil\n")
  (insert "#+BIBLIOGRAPHY: References.bib\n")
  (insert "# #+INCLUDE: abstract.org\n")
  (insert "#+begin_export latex\n\\begin{abstract}\n#+end_export\ninsert abstract here\n")
  (insert "#+begin_export latex\n\\end{abstract}\n#+end_export\n\n")
  (insert "#+begin_export latex\n\\begin{IEEEkeywords}\n#+end_export\nadd keywords here\n")
  (insert "#+begin_export latex\n\\end{IEEEkeywords}\n#+end_export\n\n")
  (insert "* Introduction\nadd intro here...\n\n* Another org heading\n\n")
  (insert "#+begin_export latex\n\\begin{figure}[htbp]\n\\centering\n\\includegraphics[width=\\columnwidth]{image.png}\n\\caption{...}\n\\label{fig:example}\n\\end{figure}\n#+end_export\n\n")
  (insert "#+begin_export latex\n\\begin{thebibliography}{00}\n\\bibitem{b1} some reference\n\\end{thebibliography}\n#+end_export\n"))

(map! :mode 'org :leader "R" #'save-and-export)
(map! :leader "o o" #'insert-org-setupfile)
(map! :leader "o m" #'insert-markdown-template)
(map! :leader "o i" #'insert-ieee-org-template)


;;; PDF Tools

(use-package pdf-tools
  :defer t
  :commands (pdf-loader-install)
  :mode "\\.pdf\\'"
  :bind (:map pdf-view-mode-map
              ("j" . pdf-view-next-line-or-next-page)
              ("k" . pdf-view-previous-line-or-next-page)
              ("C-+" . pdf-view-enlarge)
              ("C--" . pdf-view-shrink))
  :init (pdf-loader-install)
  :config
  (add-to-list 'revert-without-query ".pdf"))

(add-hook 'pdf-view-mode-hook
          (lambda () (display-line-numbers-mode -1)))


;;; AUCTeX & LaTeX 

(after! tex
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-command-default "LatexMk"
        TeX-parse-all-errors t
        TeX-master t))

(use-package! latex-preview-pane
  :after latex
  :commands latex-preview-pane-mode
  :init
  (setq latex-preview-pane-multifile-mode 'auctex
        latex-preview-pane-update-delay 0.1)
  :config
  (setq latex-preview-pane-pdf-view-command "evince")
  (when (and (eq system-type 'gnu/linux)
             (string-match "Microsoft" (shell-command-to-string "uname -a")))
    (setq latex-preview-pane-path-translation-mappings '(("/mnt/c/" . "C:/"))))
  (latex-preview-pane-enable))

(defun force-latex-preview-update ()
  (interactive)
  (when (bound-and-true-p latex-preview-pane-mode)
    (latex-preview-pane-update)))

(map! :map latex-mode-map :localleader "p" #'force-latex-preview-update)

(add-hook! 'latex-mode-hook
  (lambda ()
    (unless TeX-master
      (setq TeX-master (buffer-file-name)))
    (auto-save-mode +1)
    (setq auto-save-timeout 1
          auto-save-interval 1)))

(map! :leader
      :desc "Export region to LaTeX" 
      "L" #'org-export-region-to-latex)



;;; Web Development

(use-package! web-mode
  :mode "\\.html?\\'"
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-auto-pairing t
        web-mode-enable-auto-closing t))

(add-to-list 'auto-mode-alist '("\\.astro\\'" . web-mode))

(after! web-mode
  (setq web-mode-markup-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-css-indent-offset 2))


;;; UI Tweaks

(setq display-line-numbers-type 'relative
      confirm-kill-emacs nil)

(map!
 :leader
 "ke" #'save-buffers-kill-terminal)

(setq fancy-splash-image (concat doom-private-dir "doom-emacs-white.svg"))

;;; Treemacs & Tabs

(after! treemacs
  (setq treemacs-follow-current-file t
        treemacs-recenter-after-file-follow t
        treemacs-follow-after-init t
        treemacs-project-follow-cleanup t
        treemacs-show-hidden-files t))

(after! eyebrowse
  (centaur-tabs-headline-match))


;;; Elfeed

(use-package! elfeed)
(eval-after-load 'elfeed
  '(map! :leader :desc "Open Elfeed" "e" #'elfeed))

(use-package! org-ref
  :config
  (setq org-ref-default-bibliography '("~/path/to/references.bib")
        org-ref-bibliography-notes "~/path/to/notes.org"
        org-ref-pdf-directory "~/path/to/pdfs"))


;;; Minimap (Code Overview)

(use-package! minimap
  :config
  (setq minimap-window-location 'right
        minimap-width-fraction 0.09
        minimap-minimum-width 15
        minimap-hide-cursor t
        minimap-hide-fringes t)
  (custom-set-faces!
    '(minimap-active-region-background :background "#000000")))


;;; Org Babel - Mermaid

(use-package! ob-mermaid)

;;; Org Agenda
(setq org-agenda-span 45)


;;; vterm
(setq vterm-shell "/usr/bin/zsh")


;;; dired
(add-hook 'dired-mode-hook 'display-line-numbers-mode)


(defun my/dired-convert-to-pdf ()
  "Convert the selected .pptx file to PDF using LibreOffice."
  (interactive)
  (let ((file (dired-get-file-for-visit)))  ;; Get the current file in dired
    (when (and file (string-equal (file-name-extension file) "pptx"))
      (shell-command (format "libreoffice --headless --convert-to pdf --outdir . %s" (shell-quote-argument file)))
      (message "Converted %s to PDF!" file))))
(map! :leader
      :desc "Convert .pptx to PDF" :n "c" #'my/dired-convert-to-pdf)



(defun my/dired-marp-pptx ()
  "Run `marp --pptx <file> --allow-local-files` on the current file in dired."
  (interactive)
  (let ((file (dired-get-file-for-visit)))  ;; Get the file under the cursor
    (if (and file (string= (file-name-extension file) "md"))  ;; Check if it's a Markdown file
        (shell-command (concat "marp --pptx " (shell-quote-argument file) " --allow-local-files"))
      (message "Not a Markdown file!"))))
(map! :after dired
      :map dired-mode-map
      :n "SPC m p" #'my/dired-marp-pptx)

