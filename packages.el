;; -*- no-byte-compile: t; -*-

(package! all-the-icons-dired)

(package! info-colors )

(unpin! org-mode)

(package! org-pretty-table-mode
  :recipe (:host github
           :repo "Fuco1/org-pretty-table"))

(package! org-pretty-tags)

(package! org-fancy-priorities)

(package! ivy-bibtex)
(package! helm-bibtex)

(package! doct)

(package! org-download
  :recipe (:host github
            :repo "abo-abo/org-download"))

(package! helm-org-rifle)

(package! org-noter)

(package! ox-pandoc)

(package! org-protocol-capture-html
  :recipe (:host github
           :repo "alphapapa/org-protocol-capture-html"))

(package! org-pdftools
  :recipe (:host github
           :repo "fuxialexander/org-pdftools"))

(package! org-ref)

(package! org-roam-bibtex)

(package! org-roam-server)

(package! org-super-agenda)
