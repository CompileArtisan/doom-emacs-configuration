;;; modules/ui.el -*- lexical-binding: t; -*-

;; Fonts & Theme
(setq doom-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 22)
      doom-big-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 34)
      doom-theme 'doom-one)

;; Cursor
(custom-set-faces!
  '(cursor :background "#4DA6E3"))

;; Line numbers
(setq display-line-numbers-type 'relative
      confirm-kill-emacs nil)

;; Splash screen
(setq fancy-splash-image (expand-file-name "assets/images/doom-emacs-white.svg" doom-private-dir))

;; Initial buffer
(setq initial-buffer-choice t
      doom-fallback-buffer-name "*scratch*"
      initial-major-mode 'org-mode
      doom-scratch-initial-major-mode 'org-mode
      initial-scratch-message nil)

(with-current-buffer (get-buffer-create "*scratch*")
  (org-mode))

;; Treemacs
(after! treemacs
  (setq treemacs-follow-current-file t
        treemacs-recenter-after-file-follow t
        treemacs-follow-after-init t
        treemacs-project-follow-cleanup t
        treemacs-show-hidden-files t))

;; Tabs
(after! eyebrowse
  (centaur-tabs-headline-match))

;; Minimap
(use-package! minimap
  :config
  (setq minimap-window-location 'right
        minimap-width-fraction 0.09
        minimap-minimum-width 15
        minimap-hide-cursor t
        minimap-hide-fringes t)
  (custom-set-faces!
    '(minimap-active-region-background :background "#000000")))


