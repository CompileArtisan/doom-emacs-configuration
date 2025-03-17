(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" default))
 '(elfeed-feeds
   '("http://theverge.com/rss/index.xml" "https://compileartisan.pages.dev/rss.xml" "https://adithyanair.com/rss.xml"))
 '(org-agenda-files
   '("~/OneDrive/Study Material/Semester-4/introduction to design analysis of algorithms DAA/notes/dsa1.org"))
 '(org-safe-remote-resources
   '("\\`file:///home/praaneshnair/OneDrive/Study Material/Semester-4/introduction to design analysis of algorithms DAA/notes/my-notes-on-algorithms\\.org\\'"))
 '(package-selected-packages '(elfeed org-superstar impatient-mode grip-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(after! web-mode
  (add-to-list 'auto-mode-alist '("\\.astro\\'" . web-mode))
  (setq web-mode-content-types-alist '(("astro" . "\\.astro\\'")))
  (add-hook 'web-mode-hook #'lsp))
