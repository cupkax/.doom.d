;; -*- no-byte-compile: t; -*-

(unpin! deft)

(package! flycheck-package)

(package! all-the-icons-dired)

(package! circadian)

(unpin! doom-themes)
(package! poet-theme)
(package! spacemacs-theme
  :recipe (:local-repo "lisp/spacemacs-theme")
  :pin nil)

(package! mixed-pitch
  :recipe (:local-repo "lisp/mixed-pitch")
  :pin nil)

(unpin! org-mode)

(package! org-appear
  :recipe (:host github
           :repo "awth13/org-appear"))

(package! helm-bibtex)

(package! doct)

(unpin! org-roam)

(package! org-super-agenda)

(package! org-make-toc)

(package! ox-pandoc)
(package! org-pandoc-import
  :recipe (:host github
           :repo "tecosaur/org-pandoc-import"
           :files ("*.el" "filters" "preprocessors")))
