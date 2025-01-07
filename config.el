;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; Main font - increased from 16 to 20
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono"
                          :size 20
                          :weight 'regular))

;; Variable pitch font - also increased
(setq doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font Mono"
                                        :size 20))

;; Big headlines - increased proportionally
(setq doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono"
                              :size 28))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


(map! :i "[" #'self-insert-command)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; Define keybindings
(map!
 ;; Leader key bindings (like LazyVim's which-key menu)
 :leader
 ;; File operations
 "ff" #'find-file
 "fs" #'save-buffer

 ;; Buffer operations
 "bb" #'switch-to-buffer
 "bd" #'kill-current-buffer

 ;; Window operations
 "wv" #'split-window-right
 "ws" #'split-window-below
 "ww" #'other-window
 "wd" #'delete-window


 ;; Kill emacs
 "ke" #'kill-emacs

 )

;; Normal state bindings (like Vim normal mode)
(map! :n
      "]b" #'next-buffer
      "[b" #'previous-buffer)

(map! "C-/" #'+vterm/here)

;; (use-package! centaur-tabs
;;   :config
;;   (centaur-tabs-mode t)
;;   (setq centaur-tabs-set-icons t)
;;   (setq centaur-tabs-set-modified-marker t)
;;   (setq centaur-tabs-modified-marker "*")
;;   (setq centaur-tabs-close-button "x"))


(after! eyebrowse
  (centaur-tabs-headline-match))

;; Configure treemacs to open and follow the current directory
(after! treemacs
  (setq treemacs-follow-current-file t)
  (setq treemacs-recenter-after-file-follow t)
  ;; Add these new settings
  (setq treemacs-follow-after-init t)
  (setq treemacs-project-follow-cleanup t)
  (setq treemacs-show-hidden-files t))

;; Enable LSP
(lsp)

;; Java configuration
;;(after! lsp-java
;;  (setq lsp-java-java-path "/usr/bin/java"  ;; Adjust this path based on your java installation
;;        lsp-java-vmargs
;;          (list
;;           "-XX:+UseParallelGC"
;;           "-XX:GCTimeRatio=4"
;;           "-XX:AdaptiveSizePolicyWeight=90"
;;           "-Dsun.zip.disableMemoryMapping=true"
;;           "-Xmx2G"
;;           "-Xms100m")
;;        ;; Enable organize imports and action on save
;;        lsp-java-save-action-organize-imports t))

;; (after! lsp-java
;;   (setq lsp-java-java-path "/usr/bin/java")  ;; Replace with your Java path
;;   (setq lsp-java-server-install-dir "~/jdtls/eclipse.jdt.ls-1.34.0")) ;; Path to the extracted JDTLS folder
;;
;; (add-hook 'java-mode-hook 'company-mode)
