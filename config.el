;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Load modular configurations
(load! "modules/ui")
(load! "modules/org")
(load! "modules/latex")
(load! "modules/pdf")
(load! "modules/web")
(load! "modules/helpers")
(load! "modules/keybindings")

;; vterm
(setq vterm-shell "/usr/bin/zsh")

;; dired
(add-hook 'dired-mode-hook 'display-line-numbers-mode)

;; Elfeed
(use-package! elfeed)
