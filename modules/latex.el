;;; modules/latex.el -*- lexical-binding: t; -*-

;; Set default TeX command
(setq TeX-command-default "xelatex")

;; AUCTeX settings
(after! tex
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-command-default "LatexMk"
        TeX-parse-all-errors t
        TeX-master t))

;; LaTeX preview pane
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

;; LaTeX mode hooks
(add-hook! 'latex-mode-hook
  (lambda ()
    (unless TeX-master
      (setq TeX-master (buffer-file-name)))
    (auto-save-mode +1)
    (setq auto-save-timeout 1
          auto-save-interval 1)))


