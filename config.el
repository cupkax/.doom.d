;;; config.el -*- lexical-binding: t; -*-

(setq user-full-name "Vedant Sansare (cupkax)"
      user-mail-address "vedantsansare23@gmail.com")

(setq undo-limit 80000000)
(setq evil-want-fine-undo t)
(setq auto-save-default t)

(setq-default custom-file (expand-file-name ".custom.el" doom-private-dir))
(when (file-exists-p custom-file)
  (load custom-file))

(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8)

(setq doom-font                (font-spec :family "FiraCode Nerd Font" :size 16))
(setq doom-big-font            (font-spec :family "FiraCode Nerd Font" :size 20))
(setq doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :size 16))
(setq doom-serif-font          (font-spec :family "BlexMono Nerd Font" :weight 'light))

(setq doom-theme 'doom-palenight)

(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "grey"))

(setq display-time-24hr-format t)
(display-time-mode 1)

(use-package! info-colors
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

(add-hook 'Info-mode-hook #'mixed-pitch-mode)

(setq doom-localleader-key ",")

(use-package! general)
(defconst my-leader "SPC")
(general-create-definer my-leader-def
  :prefix my-leader)

(general-create-definer my-local-leader-def
  :prefix my-local-leader
  :prefix ",")

(general-evil-setup t)
(general-auto-unbind-keys)

(setq which-key-idle-delay 0.0)

(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
   ))

(use-package deft
      :after org
      :config
      (setq deft-recursive t)
      (setq deft-use-filter-string-for-filename t)
      (setq deft-default-extension "org")
      (setq deft-directory "~/git/phd/notes/"))

(setq-default window-combination-resize t)

(after! text-mode
  (add-hook! 'text-mode-hook
    (with-silent-modifications
      (ansi-color-apply-on-region (point-min) (point-max)))))



(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort))

(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

(setq org-directory                     "~/git/phd/notes/"
      org-use-property-inheritance      t
      org-log-done                      'time
      org-list-allow-alphabetical       t
      org-catch-invisible-edits         'smart
      org-cycle-separator-lines              0)

(setq org-roam-directory        "~/git/phd/notes/")
(setq org-roam-db-update-method 'immediate)

(use-package! org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (setq orb-preformat-keywords
        '("citekey" "title" "url" "author-or-editor" "keywords" "file")
        orb-process-file-keyword t
        orb-file-field-extensions '("pdf"))
  (setq orb-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "${citekey}"
           :head "#+TITLE: ${citekey}: ${title}\n#+ROAM_KEY: ${ref}

- tags ::
- keywords :: ${keywords}

* ${title}
:PROPERTIES:
:Custom_ID: ${citekey}
:URL: ${url}
:AUTHOR: ${author-or-editor}
:NOTER_DOCUMENT: %(orb-process-file-field \"${citekey}\")
:NOTER_PAGE:
:END:"))))

;(setq bibtex-format-citation-functions
;      '((org-mode . (lambda (x) (insert (concat
;                                         "\\cite{"
;                                         (mapconcat 'identity x ",")
;                                         "}")) ""))))


(setq
 bibtex-completion-notes-path   "~/git/phd/notes/"
 bibtex-completion-bibliography "~/Dropbox/org/research/zotLib.bib"
 bibtex-completion-library-path "~/Dropbox/org/research/zotero-library/"
 bibtex-completion-pdf-field    "file"
 bibtex-completion-notes-template-multiple-files
 (concat
  "#+TITLE: ${title}\n"
  "#+ROAM_KEY: cite:${=key=}\n"
  "#+ROAM_TAGS: ${keywords}\n"
  "* TODO Notes\n"
  ":PROPERTIES:\n"
  ":Custom_ID: ${=key=}\n"
  ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
  ":AUTHOR: ${author-abbrev}\n"
  ":JOURNAL: ${journaltitle}\n"
  ":DATE: ${date}\n"
  ":YEAR: ${year}\n"
  ":DOI: ${doi}\n"
  ":URL: ${url}\n"
  ":END:\n\n"))

(use-package! org-noter
  :after (:any org pdf-view)
  :config
  (setq
   org-noter-hide-other nil
   org-noter-notes-search-path (list "~/git/phd/notes/")))
(map! :localleader
      :map (org-mode-map pdf-view-mode)
      (:prefix ("o" . "Org")
       (:prefix ("n" . "Noter")
         :desc "Noter" "n" 'org-noter)))

(use-package! ox-pandoc
  :after org)
;; default options for all output formats
(setq org-pandoc-options '((standalone . _)))
;; cancel above settings only for 'docx' format
(setq org-pandoc-options-for-docx '((standalone . nil)))
;; special extensions for markdown_github output
(setq org-pandoc-format-extensions '(markdown_github+pipe_tables+raw_html))

(after! pdf-view
  (setq-default pdf-view-display-size 'fit-width)
  (setq pdf-annot-activate-created-annotations t
        pdf-view-resize-factor 1.1))

(map!
 :map (pdf-view-mode-map)
 :n "g g"  #'pdf-view-first-page
 :n "G"    #'pdf-view-last-page
 :n "n"    #'pdf-view-next-page-command
 :n "N"    #'pdf-view-previous-page-command
 :localleader
 (:prefix "o"
  (:prefix "n"
   :desc "Insert Note" "n" 'org-noter-insert-note)))

(use-package! zotxt
  :after org)
