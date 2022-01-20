;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! circadian
  :recipe (:host github
           :repo "guidoschmidt/circadian.el"))

(unpin! biblio)
(unpin! org)
(unpin! org-roam)
(package! org-roam-ui)
(package! websocket)
(package! simple-httpd)
(package! f)

(package! org-pretty-table
  :recipe (:host github :repo "Fuco1/org-pretty-table"))

(package! org-fragtog)
(package! org-appear)
(package! org-transclusion)
(package! org-pandoc-import
  :recipe (:host github
           :repo "tecosaur/org-pandoc-import"
           :files ("*.el" "filters" "preprocessors")))
