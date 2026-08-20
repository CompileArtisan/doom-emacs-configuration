;;; modules/keybindings.el -*- lexical-binding: t; -*-

;; Org mode
(map! :map org-mode-map
      :leader
      :desc "Save and export PDF"
      "R" #'save-and-export-pdf
      :desc "Save and export Markdown"
      "M" #'save-and-export-markdown
      :desc "Save and export HTML"
      "H" #'save-and-export-html)

(map! :leader "o o" #'insert-org-setupfile)
(map! :leader "o m" #'insert-markdown-template)
(map! :leader "o i" #'insert-ieee-org-template)
(map! :leader "L" #'org-export-region-to-latex)

(map! :leader
      :desc "Export to PDF"
      "R" #'my/export-pdf)

;; Agenda
(map! :leader "oat" #'pn/open-agenda-tasks)
(map! :leader "oar" #'pn/open-agenda-routine)
(map! :leader "oac" #'pn/open-agenda-college)

;; Exit
(map! :leader "ke" #'save-buffers-kill-terminal)

;; Dired
(map! :leader "c" #'my/dired-convert-to-pdf)
(map! :after dired
      :map dired-mode-map
      :n "SPC m p" #'my/dired-marp-pptx)

(map! :after dired
      :map dired-mode-map
      :n "y f" #'my/yank-file-uri)

(map! :leader
      :desc "Open Dirvish"
      "o d" #'dirvish)

;; LaTeX
(map! :map latex-mode-map :localleader "p" #'force-latex-preview-update)

;; Elfeed
(eval-after-load 'elfeed
  '(map! :leader :desc "Open Elfeed" "e" #'elfeed))
