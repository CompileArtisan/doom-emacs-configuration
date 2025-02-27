;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 20)
      doom-variable-pitch-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 24)
      doom-big-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 36))

(setq doom-theme 'doom-one)
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

(map!
:leader
"ff" #'find-file
"fs" #'save-buffer
"bb" #'switch-to-buffer
"bd" #'kill-current-buffer
"wv" #'split-window-right
"ws" #'split-window-below
"ww" #'other-window
"wd" #'delete-window
"ke" #'save-buffers-kill-terminal)

(after! eyebrowse
 (centaur-tabs-headline-match))

(after! treemacs
 (setq treemacs-follow-current-file t)
 (setq treemacs-recenter-after-file-follow t)
 (setq treemacs-follow-after-init t)
 (setq treemacs-project-follow-cleanup t)
 (setq treemacs-show-hidden-files t))

(lsp)

(after! org 
 (set-face-attribute 'org-level-1 nil :height 1.1 :weight 'normal)
 (set-face-attribute 'org-level-2 nil :height 1.1 :weight 'normal)
 (set-face-attribute 'org-level-3 nil :height 1.1 :weight 'normal)
 (set-face-attribute 'org-document-title nil :height 1.5 :weight 'bold))
