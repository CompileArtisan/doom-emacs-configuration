;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


(setq doom-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 20)
      doom-variable-pitch-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 24)
      doom-big-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 36))
(setq doom-theme 'doom-one)
;;(setq doom-theme 'catppuccin)
(setq org-latex-listings t)
(after! org
  (setq org-latex-src-block-backend 'listings))

(setq display-line-numbers-type 'relative)
(setq org-directory "~/org/")
(setq copilot-mode nil)
(use-package! minimap
 :config
 (setq minimap-window-location 'right
       minimap-width-fraction 0.09
       minimap-minimum-width 15
       minimap-hide-cursor t
       minimap-hide-fringes t)
 (custom-set-faces!
   '(minimap-active-region-background
     :background "#000000")))
(remove-hook 'server-after-make-frame-hook #'doom-display-benchmark-h)

(use-package! web-mode
 :mode "\\.html?\\'"
 :config
 (setq web-mode-markup-indent-offset 2)
 (setq web-mode-css-indent-offset 2)
 (setq web-mode-code-indent-offset 2)
 (setq web-mode-enable-auto-pairing t)
 (setq web-mode-enable-auto-closing t))

(add-to-list 'auto-mode-alist '("\\.astro\\'" . web-mode))
(after! web-mode
 (setq web-mode-markup-indent-offset 2)
 (setq web-mode-code-indent-offset 2)
 (setq web-mode-css-indent-offset 2))

(use-package pdf-tools
 :defer t
 :commands (pdf-loader-install)
 :mode "\\.pdf\\'"
 :bind (:map pdf-view-mode-map
             ("j" . pdf-view-next-line-or-next-page)
             ("k" . pdf-view-previous-line-or-previous-page)
             ("C-+" . pdf-view-enlarge)
             ("C--" . pdf-view-shrink))
 :init (pdf-loader-install)
 :config
 (add-to-list 'revert-without-query ".pdf"))

(add-hook 'pdf-view-mode-hook
         (lambda ()
           (display-line-numbers-mode -1)))

(setq confirm-kill-emacs nil)


(after! tex
 (setq TeX-auto-save t)
 (setq TeX-parse-self t)
 (setq-default TeX-master t)
 (setq TeX-parse-all-errors t)
 (setq TeX-command-default "LatexMk"))

(use-package! latex-preview-pane
 :after latex
 :commands latex-preview-pane-mode
 :init
 (setq latex-preview-pane-multifile-mode 'auctex)
 (setq latex-preview-pane-update-delay 0.1)
 :config
 (setq latex-preview-pane-pdf-view-command "evince")
 (when (and (eq system-type 'gnu/linux)
            (string-match "Microsoft" (shell-command-to-string "uname -a")))
   (setq latex-preview-pane-path-translation-mappings
         '(("/mnt/c/" . "C:/"))))
 (latex-preview-pane-enable))

(after! org 
 (setq org-babel-default-header-args:java '((:dir . nil) (:results . "value"))) 
 (org-babel-do-load-languages 'org-babel-load-languages '((java . t))))

(add-hook! 'latex-mode-hook
 (lambda ()
   (unless TeX-master
     (setq TeX-master (buffer-file-name)))
   (auto-save-mode +1)
   (setq auto-save-timeout 1)
   (setq auto-save-interval 1)))

(defun force-latex-preview-update ()
 (interactive)
 (when (bound-and-true-p latex-preview-pane-mode)
   (latex-preview-pane-update)))

(map! :map latex-mode-map
     :localleader
     "p" #'force-latex-preview-update)

(add-hook 'org-mode-hook
          (lambda ()
            (setq org-export-with-broken-links t)))


(map!
:leader
"ke" #'save-buffers-kill-terminal)

(after! eyebrowse
 (centaur-tabs-headline-match))

(after! treemacs
 (setq treemacs-follow-current-file t)
 (setq treemacs-recenter-after-file-follow t)
 (setq treemacs-follow-after-init t)
 (setq treemacs-project-follow-cleanup t)
 (setq treemacs-show-hidden-files t))

(after! org 
 (set-face-attribute 'org-level-1 nil :height 1.1 :weight 'normal)
 (set-face-attribute 'org-level-2 nil :height 1.1 :weight 'normal)
 (set-face-attribute 'org-level-3 nil :height 1.1 :weight 'normal)
 (set-face-attribute 'org-document-title nil :height 1.5 :weight 'bold))

; Open Elfeed with the keybinding `SPC a e`
(use-package! elfeed)
(eval-after-load 'elfeed
  '(map! :leader
         :desc "Open Elfeed" "e" #'elfeed))

(use-package! org-ref
  :config
  (setq org-ref-default-bibliography '("~/path/to/references.bib")
        org-ref-bibliography-notes "~/path/to/notes.org"
        org-ref-pdf-directory "~/path/to/pdfs"))


;; Adithya's function for me :)
(defun save-and-export ()
  "This is just a helper function."
  (interactive)
        (save-buffer)
        (org-latex-export-to-pdf))

(map! :mode 'org :leader "R" #'save-and-export)



;; function to insert preamble line
(defun insert-org-setupfile ()
  "Insert a #+SETUPFILE directive for the Org preamble."
  (interactive)
  (insert "#+SETUPFILE: /home/praanesh-nair/.config/doom/preamble.org\n"))

(map! :leader
      :desc "Insert Org SETUPFILE preamble"
      "o o" #'insert-org-setupfile)


;; mermaid in org
(use-package! ob-mermaid)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-tsx-mode))

(use-package! prettier
  :hook (js-mode . prettier-mode)
  :hook (web-mode . prettier-mode)
  :hook (typescript-mode . prettier-mode)
  :hook (html-mode . prettier-mode)
  :hook (css-mode . prettier-mode)
  :config
  (setq prettier-args '("--single-quote" "--trailing-comma" "es5")))


;; function to insert markdown headers in org
(defun insert-markdown-template ()
  "Insert a markdown template with YAML frontmatter and TOC options."
  (interactive)
  (insert "#+OPTIONS: toc:nil\n")
  (insert "#+begin_export markdown\n")
  (insert "---\n")
  (insert "title: \"placeholder\"\n")
  (insert "date: YYYY-MM-DD\n")
  (insert "description: \"placeholder\"\n")
  (insert "---\n")
  (insert "#+end_export\n")
  (insert "\n")
  (insert "#+TOC: headlines 2\n"))

(map! :leader
      :desc "Insert Markdown Template"
      "o m" #'insert-markdown-template)


;; function to inesrt ieee template
(defun insert-ieee-org-template ()
  "Insert IEEE Org-mode LaTeX export template."
  (interactive)
  (insert "#+TITLE: insert title here\n")
  (insert "#+SETUPFILE: /home/praaneshnair/.config/doom/ieee.org\n")
  (insert "#+LATEX_HEADER: \\input{/home/praaneshnair/.config/doom/def.tex}\n")
  (insert "#+LATEX_HEADER: \\input{/home/praaneshnair/.config/doom/author.tex}\n")
  (insert "#+LATEX_HEADER: \\graphicspath{ {.} }\n")
  (insert "#+OPTIONS: toc:nil ^:{} author:nil date:nil\n")
  (insert "#+BIBLIOGRAPHY: References.bib\n")
  (insert "# #+INCLUDE: abstract.org\n")
  (insert "#+begin_export latex\n\\begin{abstract}\n#+end_export\n")
  (insert "insert abstract here\n")
  (insert "#+begin_export latex\n\\end{abstract}\n#+end_export\n\n")
  (insert "#+begin_export latex\n\\begin{IEEEkeywords}\n#+end_export\n")
  (insert "add keywords here\n")
  (insert "#+begin_export latex\n\\end{IEEEkeywords}\n#+end_export\n\n")
  (insert "* Introduction\nadd intro here. feel free to make as many org-headings you like\n\n")
  (insert "* Another org heading\n\n")
  (insert "#+begin_export latex\n\\begin{figure}[htbp]\n    \\centering\n    \\includegraphics[width=\\columnwidth]{image.png}\n    \\caption{This is how you insert images}\n    \\label{fig:example}\n\\end{figure}\n#+end_export\n\n")
  (insert "#+begin_export latex\n\\begin{thebibliography}{00}\n#+end_export\n")
  (insert "\\bibitem{b1} some reference\n")
  (insert "#+begin_export latex\n\\end{thebibliography}\n#+end_export\n"))

(map! :leader
      :desc "Insert IEEE Org Template"
      "o i" #'insert-ieee-org-template)
