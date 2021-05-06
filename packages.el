;; -*- no-byte-compile: t; -*-

(package! flycheck-package)

(package! all-the-icons-dired)

(package! org-pretty-table
  :recipe (:host github :repo "Fuco1/org-pretty-table"))

(package! circadian)

(unpin! doom-themes)
;(package! doom-themes)
(package! poet-theme)
(package! spacemacs-theme
  :recipe (:local-repo "lisp/spacemacs-theme")
  :pin nil)

(package! mixed-pitch
  :recipe (:local-repo "lisp/mixed-pitch")
  :pin nil)

(unpin! org-mode)

(package! org-chef)

(package! org-appear
  :recipe (:host github
           :repo "awth13/org-appear"))

(package! helm-bibtex)

(package! org-download
  :recipe (:host github
           :repo "abo-abo/org-download"))

(package! org-pdftools
  :recipe (:host github
           :repo "fuxialexander/org-pdftools"))

(package! org-ql)
(package! helm-org-ql)

(unpin! org-roam)

(package! org-roam-bibtex)

(package! org-make-toc)

(package! ox-pandoc)
(package! org-pandoc-import
  :recipe (:host github
           :repo "tecosaur/org-pandoc-import"
           :files ("*.el" "filters" "preprocessors")))

(package! with-shell-interpreter)
