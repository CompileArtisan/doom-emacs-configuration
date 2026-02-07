;;; modules/helpers.el -*- lexical-binding: t; -*-

(defun save-and-export-pdf ()
  "Save and export current Org buffer to PDF via LaTeX."
  (interactive)
  (save-buffer)
  (org-latex-export-to-pdf))

(defun save-and-export-markdown ()
  "Save and export current Org buffer to Markdown."
  (interactive)
  (save-buffer)
  (org-md-export-to-markdown))

(defun save-and-export-html ()
  "Save and export current Org buffer to HTML."
  (interactive)
  (save-buffer)
  (org-html-export-to-html))


(defun insert-org-setupfile ()
  "Insert SETUPFILE directive with portable path."
  (interactive)
  (insert (format "#+SETUPFILE: %s\n" 
                  (expand-file-name "templates/org/html-preamble.org" doom-private-dir))))

(defun insert-markdown-template ()
  "Insert YAML + Markdown structure for Org export."
  (interactive)
  (insert "#+OPTIONS: toc:nil\n#+begin_export markdown\n")
  (insert "---\ntitle: \"placeholder\"\ndate: YYYY-MM-DD\ndescription: \"placeholder\"\n---\n")
  (insert "#+end_export\n\n#+TOC: headlines 2\n"))

(defun insert-ieee-org-template ()
  "Insert IEEE-compliant Org export template."
  (interactive)
  (let ((templates-dir (expand-file-name "templates/latex/" doom-private-dir)))
    (insert "#+TITLE: insert title here\n")
    (insert (format "#+SETUPFILE: %s\n" (expand-file-name "ieee-preamble.org" templates-dir)))
    (insert (format "#+LATEX_HEADER: \\input{%s}\n" (expand-file-name "def.tex" templates-dir)))
    (insert (format "#+LATEX_HEADER: \\input{%s}\n" (expand-file-name "author.tex" templates-dir)))
    (insert "#+LATEX_HEADER: \\graphicspath{ {.} }\n")
    (insert "#+OPTIONS: toc:nil ^:{} author:nil date:nil\n")
    (insert "#+BIBLIOGRAPHY: References.bib\n")
    (insert "# #+INCLUDE: abstract.org\n")
    (insert "#+begin_export latex\n\\begin{abstract}\n#+end_export\ninsert abstract here\n")
    (insert "#+begin_export latex\n\\end{abstract}\n#+end_export\n\n")
    (insert "#+begin_export latex\n\\begin{IEEEkeywords}\n#+end_export\nadd keywords here\n")
    (insert "#+begin_export latex\n\\end{IEEEkeywords}\n#+end_export\n\n")
    (insert "* Introduction\nadd intro here...\n\n* Another org heading\n\n")
    (insert "#+begin_export latex\n\\begin{figure}[htbp]\n\\centering\n\\includegraphics[width=\\columnwidth]{image.png}\n\\caption{...}\n\\label{fig:example}\n\\end{figure}\n#+end_export\n\n")
    (insert "#+begin_export latex\n\\begin{thebibliography}{00}\n\\bibitem{b1} some reference\n\\end{thebibliography}\n#+end_export\n")))

(defun pn/open-agenda-tasks ()
  "Open the default agenda view filtered to the :tasks: tag."
  (interactive)
  (org-agenda nil "a")
  (org-agenda-filter-apply '("+tasks") 'tag))

(defun pn/open-agenda-routine ()
  "Open the default agenda view filtered to the :routine: tag."
  (interactive)
  (org-agenda nil "a")
  (org-agenda-filter-apply '("+routine") 'tag))

(defun pn/open-agenda-college ()
  "Open the default agenda view filtered to the :college: tag."
  (interactive)
  (org-agenda nil "a")
  (org-agenda-filter-apply '("+college") 'tag))

(defun my/dired-convert-to-pdf ()
  "Convert the selected .pptx file to PDF using LibreOffice."
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (when (and file (string-equal (file-name-extension file) "pptx"))
      (shell-command (format "libreoffice --headless --convert-to pdf --outdir . %s" 
                             (shell-quote-argument file)))
      (message "Converted %s to PDF!" file))))

(defun my/dired-marp-pptx ()
  "Run `marp --pptx <file> --allow-local-files` on the current file in dired."
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (if (and file (string= (file-name-extension file) "md"))
        (shell-command (concat "marp --pptx " (shell-quote-argument file) " --allow-local-files"))
      (message "Not a Markdown file!"))))


(defun my/current-date-formatted ()
  "Used in a yasnippet to quickly insert my blog frontmatter boilerplate."
  (setq value (calendar-current-date))
  (format "%04d-%02d-%02d"
          (nth 2 value)  ; year
          (nth 0 value)  ; month
          (nth 1 value))) ; day

(defun my/yank-file-uri ()
  "Copy file URI(s) to clipboard using wl-copy."
  (interactive)
  (let* ((files (if (derived-mode-p 'dired-mode)
                    (dired-get-marked-files)
                  (list (buffer-file-name))))
         (uris (mapconcat (lambda (f)
                            (concat "file://" (expand-file-name f)))
                          files
                          "\n")))
    (when uris
      (with-temp-buffer
        (insert uris)
        (call-process-region (point-min) (point-max)
                             "wl-copy" nil nil nil
                             "--type" "text/uri-list"))
      (message "Copied %d file URI(s)" (length files)))))

