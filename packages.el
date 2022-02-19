;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Unpins
(unpin! (:completion company vertico))
(unpin! (:ui deft modeline unicode zen))
(unpin! (:editor format snippets word-wrap))
(unpin! (:checkers))
(unpin! (:tools biblio pdf))
(unpin! (:lang))

;; New packages
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

(package! graphviz-dot-mode)
