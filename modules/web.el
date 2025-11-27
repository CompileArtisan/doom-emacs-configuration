;;; modules/web.el -*- lexical-binding: t; -*-

(use-package! web-mode
  :mode "\\.html?\\'"
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-auto-pairing t
        web-mode-enable-auto-closing t))

;; Astro support
(add-to-list 'auto-mode-alist '("\\.astro\\'" . web-mode))

(after! web-mode
  (setq web-mode-markup-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-css-indent-offset 2))


