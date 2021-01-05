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
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
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
      :bind
      ("C-c n d" . deft)
      :custom
      (deft-recursive t)
      (deft-use-filter-string-for-filename t)
      (deft-default-extension "org")
      (deft-directory "~/git/phd/notes/"))

(use-package! bufler
  :general
  (:keymaps 'doom-leader-map
   "b b" 'bufler-workspace-switch-buffer
   "b B" 'bufler-switch-buffer)
  :config
  (setq bufler-workspace-switch-buffer-sets-workspace t))

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

(set-company-backend!
  '(text-mode
    markdown-mode
    gfm-mode)
  '(:seperate
    company-ispell
    company-files
    company-yasnippet))

(setq org-directory                     "~/git/phd/notes/"
      org-use-property-inheritance      t
      org-log-done                      'time
      org-list-allow-alphabetical       t
      org-catch-invisible-edits         'smart
      org-cycle-separator-lines              0)

(use-package! helm-org-rifle
  :after org
  :general
  (:keymaps 'org-mode-map
            :states 'normal
            :prefix my-leader
            "m r"     '(:ignore t                       :wk "Rifle (Helm)")
            "m r b"   '(helm-org-rifle-current-buffer   :wk "Rifle buffer")
            "m r e"   '(helm-org-rifle                  :wk "Rifle every open buffer")
            "m r d"   '(helm-org-rifle-directory        :wk "Rifle from org-directory")
            "m r a"   '(helm-org-rifle-agenda-files     :wk "Rifle agenda")
            "m r o"   '(:ignore t                       :wk "Occur (Persistent)")
            "m r o b" '(helm-org-rifle-current-buffer   :wk "Rifle buffer")
            "m r o e" '(helm-org-rifle                  :wk "Rifle every open buffer")
            "m r o d" '(helm-org-rifle-directory        :wk "Rifle from org-directory")
            "m r o a" '(helm-org-rifle-agenda-files     :wk "Rifle agenda")
            ))

(use-package! org-mind-map
  :general
  (:keymaps 'org-mode-map
            :states 'normal
            :prefix my-leader
            "m e m" '(org-mind-map-write :wk "Export mind-map") ))

(use-package! org-ref
    :after org
    :init
    ; code to run before loading org-ref
    :config
    ; code to run after loading
    ; org-ref
    
    (setq
     org-ref-completion-library        'org-ref-ivy-cite
     org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
     org-ref-bibliography-notes        "~/git/phd/notes/bibnotes.org"
     org-ref-note-title-format         "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
     org-ref-notes-directory           "~/git/phd/notes"
     org-ref-default-bibliography      '("~/Dropbox/org/research/zotLib.bib")
     org-ref-pdf-directory             "~/Dropbox/org/research/zotero-library"
     org-ref-notes-function            'orb-edit-notes))

(setq org-roam-directory "~/git/phd/notes/")

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

(setq bibtex-format-citation-functions
      '((org-mode . (lambda (x) (insert (concat
                                         "\\cite{"
                                         (mapconcat 'identity x ",")
                                         "}")) ""))))


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

(map! :localleader
      :map (org-mode-map pdf-view-mode-map)
      (:prefix ("o" . "Org")
       (:prefix ("n" . "Noter")
        :desc "Noter" "n" 'org-noter
        )))

(use-package! org-noter
  :after (:any org pdf-view)
  :config
  (setq
   org-noter-hide-other nil
   ;; Everything is relative to the rclone mega
   org-noter-notes-search-path (list "~/git/phd/notes/")))

(use-package! ox-pandoc
  :after org)
;; default options for all output formats
(setq org-pandoc-options '((standalone . _)))
;; cancel above settings only for 'docx' format
(setq org-pandoc-options-for-docx '((standalone . nil)))
;; special extensions for markdown_github output
(setq org-pandoc-format-extensions '(markdown_github+pipe_tables+raw_html))

(setq ispell-dictionary "en-custom")
(setq ispell-personal-dictionary (expand-file-name ".ispell_personal" doom-private-dir))

(after! pdf-view
  (setq-default pdf-view-display-size 'fit-width)
  (setq pdf-annot-activate-created-annotations t
        pdf-view-resize-factor 1.1)
  (map!
   :map pdf-view-mode-map
   :n "g g"          #'pdf-view-first-page
   :n "G"            #'pdf-view-last-page
   :n "N"            #'pdf-view-next-page-command
   :n "E"            #'pdf-view-previous-page-command
   :n "e"            #'evil-collection-pdf-view-previous-line-or-previous-page
   :n "n"            #'evil-collection-pdf-view-next-line-or-next-page
   :localleader
   (:prefix "o"
    (:prefix "n"
     :desc "Insert" "i" 'org-noter-insert-note
     ))))

(use-package! zotxt
  :after org)
