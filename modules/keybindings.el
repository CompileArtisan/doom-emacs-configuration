;;; modules/keybindings.el -*- lexical-binding: t; -*-

;; Org mode
(map! :mode 'org :leader "M" #'save-and-export-markdown)
(map! :mode 'org :leader "R" #'save-and-export-pdf)
(map! :mode 'org :leader "H" #'save-and-export-html)
(map! :leader "o o" #'insert-org-setupfile)
(map! :leader "o m" #'insert-markdown-template)
(map! :leader "o i" #'insert-ieee-org-template)
(map! :leader "L" #'org-export-region-to-latex)

;; Agenda
(map! :leader "oat" #'pn/open-agenda-tasks)
(map! :leader "oar" #'pn/open-agenda-routine)

;; Exit
(map! :leader "ke" #'save-buffers-kill-terminal)

;; Dired
(map! :leader "c" #'my/dired-convert-to-pdf)
(map! :after dired
      :map dired-mode-map
      :n "SPC m p" #'my/dired-marp-pptx)

;; LaTeX
(map! :map latex-mode-map :localleader "p" #'force-latex-preview-update)

;; Elfeed
(eval-after-load 'elfeed
  '(map! :leader :desc "Open Elfeed" "e" #'elfeed))
