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

;; Enable smooth pixel-precision scrolling globally
(pixel-scroll-precision-mode 1)
(setq idle-update-delay 0.01)
(setq jit-lock-defer-time 0)
(setq jit-lock-stealth-time 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)

(setq scroll-step 1
      scroll-conservatively 101)

;; Elfeed
(use-package! elfeed)

;; mdx support
(add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))

;; orgbabel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

