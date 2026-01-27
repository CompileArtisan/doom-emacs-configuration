;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Load modular configurations
(load! "modules/ui")
(load! "modules/org")
(load! "modules/latex")
(load! "modules/pdf")
(load! "modules/web")
(load! "modules/helpers")
(load! "modules/keybindings")
(load! "modules/ob-mongo")
(load! "modules/jupyter")

;; vterm
(setq vterm-shell "/usr/bin/zsh")

;; dired
(add-hook 'dired-mode-hook 'display-line-numbers-mode)

;; Elfeed
(use-package! elfeed)

;; mdx support
(add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))

;; orgbabel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))
