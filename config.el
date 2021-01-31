;; [[file:README.org::*=Emacs 28= Fix][=Emacs 28= Fix:1]]
(define-advice define-obsolete-function-alias (:filter-args (ll) fix-obsolete)
  (let ((obsolete-name (pop ll))
        (current-name (pop ll))
        (when (if ll (pop ll) "1"))
        (docstring (if ll (pop ll) nil)))
    (list obsolete-name current-name when docstring)))
;; =Emacs 28= Fix:1 ends here

;; [[file:README.org::*Lexical Bindings][Lexical Bindings:1]]
;;; config.el -*- lexical-binding: t; -*-
;; Lexical Bindings:1 ends here

;; [[file:README.org::*Better Defaults][Better Defaults:1]]
(setq undo-limit 80000000)
(setq evil-want-fine-undo t)
(setq auto-save-default t)
(setq global-subword-mode 1)
;; Better Defaults:1 ends here

;; [[file:README.org::*=custom.el=][=custom.el=:1]]
(setq-default custom-file (expand-file-name ".custom.el" doom-private-dir))
(when (file-exists-p custom-file)
  (load custom-file))
;; =custom.el=:1 ends here

;; [[file:README.org::*=utf-8-unix= System][=utf-8-unix= System:1]]
(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8)
;; =utf-8-unix= System:1 ends here

;; [[file:README.org::*Fonts][Fonts:1]]
(setq inhibit-compacting-font-caches t)
(setq doom-font                (font-spec :family "JetBrainsMono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "Alegreya" :weight 'semibold :size 21)
      doom-unicode-font        (font-spec :family "DejaVuSansMono Nerd Font"))
;; Fonts:1 ends here

;; [[file:README.org::*Unicode][Unicode:1]]
(after! unicode-fonts
  (push "Symbola" (cadr (assoc "Miscellaneous Symbols" unicode-fonts-block-font-mapping))))
;; Unicode:1 ends here

;; [[file:README.org::*Theme][Theme:1]]
(setq doom-theme 'poet)
(use-package circadian
  :config
  (setq circadian-themes '(("6:00"  . spacemacs-light)
                           ("18:30" . spacemacs-dark)))
  (circadian-setup))
;; Theme:1 ends here

;; [[file:README.org::*Change red text][Change red text:1]]
(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "grey"))
;; Change red text:1 ends here

;; [[file:README.org::*Remove default load average][Remove default load average:1]]
(setq-default display-time-default-load-average nil
              display-time-load-average nil)
;; Remove default load average:1 ends here

;; [[file:README.org::*Show time][Show time:1]]
(setq display-time-24hr-format t)
(display-time-mode 1)
;; Show time:1 ends here

;; [[file:README.org::*Line Numbers][Line Numbers:1]]
(setq display-line-numbers-type nil)
;; Line Numbers:1 ends here

;; [[file:README.org::*HL-Mode][HL-Mode:1]]
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)
;; HL-Mode:1 ends here

;; [[file:README.org::*Auto-unbind][Auto-unbind:1]]
(general-auto-unbind-keys)
;; Auto-unbind:1 ends here

;; [[file:README.org::*Change local leader][Change local leader:1]]
(setq doom-localleader-key ",")
;; Change local leader:1 ends here

;; [[file:README.org::*Key delay][Key delay:1]]
(setq which-key-idle-delay 0.0)
;; Key delay:1 ends here

;; [[file:README.org::*Replace =evil= with unicode][Replace =evil= with unicode:1]]
(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
   ))
;; Replace =evil= with unicode:1 ends here

;; [[file:README.org::*Deft][Deft:1]]
(use-package deft
      :after org
      :config
      (setq deft-recursive t)
      (setq deft-use-filter-string-for-filename t)
      (setq deft-default-extension "org")
      (setq deft-directory "~/git/phd/notes/"))
;; Deft:1 ends here

;; [[file:README.org::*Buffer Config][Buffer Config:1]]
(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")
;; Buffer Config:1 ends here

;; [[file:README.org::*Frame Title][Frame Title:1]]
(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?  buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))
;; Frame Title:1 ends here

;; [[file:README.org::*Manage windows][Manage windows:1]]
(map!
 :leader
 :desc "Switch to Left Window"  "<left>"  #'evil-window-left
 :desc "Switch to Right Window" "<right>" #'evil-window-right)
;; Manage windows:1 ends here

;; [[file:README.org::*Window Split][Window Split:1]]
(setq evil-vsplit-window-right t
      evil-split-window-below  t)
(setq +ivy-buffer-preview t)
;; Window Split:1 ends here

;; [[file:README.org::*Window Resize][Window Resize:1]]
(setq-default window-combination-resize t)
;; Window Resize:1 ends here

;; [[file:README.org::*Parentheses][Parentheses:1]]
(sp-local-pair
 '(org-mode)
 "<<" ">>"
 :actions '(insert))
;; Parentheses:1 ends here

;; [[file:README.org::*YASnippet][YASnippet:1]]
(setq yas-triggers-in-field t)
;; YASnippet:1 ends here

;; [[file:README.org::*Defaults][Defaults:1]]
(setq-default major-mode 'org-mode)
(setq org-directory                     "~/git/"
      org-use-property-inheritance      t        ; Property inheritance for sublevels
      org-log-done                      'time    ; Record arguments when task is DONE
      org-list-allow-alphabetical       t        ; Alphabetical bullets
      org-export-in-background          t        ; Export in background
      org-catch-invisible-edits         'smart   ; Check invisible region before insert/delete
      org-cycle-separator-lines              0)

(remove-hook 'text-mode-hook #'visual-line-mode) ; Remove visual line mode
(add-hook 'text-mode-hook #'auto-fill-mode)      ; Enable auto fill mode

;; Ignore org default template
(set-file-template! "\\.org$" :ignore t)

;; Org block templates
(setq org-structure-template-alist
      '(("e" . "src emacs-lisp")))
;; Defaults:1 ends here

;; [[file:README.org::*Remove visual hooks][Remove visual hooks:1]]
(remove-hook 'org-mode-hook #'org-fancy-priorities-mode)
(remove-hook 'org-mode-hook #'org-superstar-mode)
;; Remove visual hooks:1 ends here

;; [[file:README.org::*Org Defaults][Org Defaults:1]]
(setq org-startup-indented t
      org-fontify-quote-and-verse-blocks t)
;; Org Defaults:1 ends here

;; [[file:README.org::*Mixed Pitch Mode][Mixed Pitch Mode:1]]
(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode)
(setq mixed-pitch-set-height t)
;; Mixed Pitch Mode:1 ends here

;; [[file:README.org::*Pretty tables][Pretty tables:1]]
(setq global-org-pretty-table-mode t)
;; Pretty tables:1 ends here

;; [[file:README.org::*Headings][Headings:1]]
(custom-set-faces!
  '(outline-1 :weight bold       :height 1.15)
  '(outline-2 :weight bold       :height 1.12)
  '(outline-3 :weight bold       :height 1.09)
  '(outline-4 :weight semi-bold  :height 1.06)
  '(outline-5 :weight semi-bold  :height 1.03)
  '(outline-6 :weight semi-bold  :height 1.01)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold)

  '(org-document-title           :height 1.2))
;; Headings:1 ends here

;; [[file:README.org::*Agenda Errors][Agenda Errors:1]]
(setq org-agenda-deadline-faces
      '((1.001 . error)
        (1.0   . org-warning)
        (0.5   . org-upcoming-deadline)
        (0.0   . org-upcoming-distant-deadline)))
;; Agenda Errors:1 ends here

;; [[file:README.org::*Bullets / Endings][Bullets / Endings:1]]
(setq org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a.")))
(setq org-ellipsis " ▾ ")
;; Bullets / Endings:1 ends here

;; [[file:README.org::*Other Symbols][Other Symbols:1]]
(appendq! +ligatures-extra-symbols
          `(:checkbox      "☐"
            :pending       "🕑"
            :checkedbox    "☑"
            :list_property "∷"
            :em_dash       "—"
            :ellipses      "…"
            :options       "⌥"
            :begin_quote   "❮"
            :end_quote     "❯"
            :caption       "☰"
            :header        "›"
            :begin_export  "⯮"
            :end_export    "⯬"
            ))
(set-ligatures! 'org-mode
  :merge t
  :checkbox      "[ ]"
  :pending       "[-]"
  :checkedbox    "[X]"
  :list_property "::"
  :em_dash       "---"
  :ellipsis      "..."
  :options       "#+options:"
  :begin_quote   "#+begin_quote"
  :end_quote     "#+end_quote"
  :caption       "#+caption:"
  :header        "#+header:"
  :begin_export  "#+begin_export"
  :end_export    "#+end_export"
  )
                                        ;(plist-put +ligatures-extra-symbols :name "⁍")
;; Other Symbols:1 ends here

;; [[file:README.org::*LSP Mode][LSP Mode:1]]
(cl-defmacro lsp-org-babel-enable (lang)
  "Support LANG in org source code block."
  (setq centaur-lsp 'lsp-mode)
  (cl-check-type lang stringp)
  (let* ((edit-pre (intern (format "org-babel-edit-prep:%s" lang)))
         (intern-pre (intern (format "lsp--%s" (symbol-name edit-pre)))))
    `(progn
       (defun ,intern-pre (info)
         (let ((file-name (->> info caddr (alist-get :file))))
           (unless file-name
             (setq file-name (make-temp-file "babel-lsp-")))
           (setq buffer-file-name file-name)
           (lsp-deferred)))
       (put ',intern-pre 'function-documentation
            (format "Enable lsp-mode in the buffer of org source block (%s)."
                    (upcase ,lang)))
       (if (fboundp ',edit-pre)
           (advice-add ',edit-pre :after ',intern-pre)
         (progn
           (defun ,edit-pre (info)
             (,intern-pre info))
           (put ',edit-pre 'function-documentation
                (format "Prepare local buffer environment for org source block (%s)."
                        (upcase ,lang))))))))
;; LSP Mode:1 ends here

;; [[file:README.org::*Capture][Capture:1]]

;; Capture:1 ends here

;; [[file:README.org::*=org-babel= evaluation arguements][=org-babel= evaluation arguements:1]]
(setq org-babel-default-header-args
      '((:session  . "none")
        (:results  . "replace")
        (:exports  . "code")
        (:cache    . "no")
        (:noweb    . "no")
        (:hlines   . "no")
        (:tangle   . "no")
        (:comments . "link")))
;; =org-babel= evaluation arguements:1 ends here

;; [[file:README.org::*=org-babel= languages][=org-babel= languages:1]]
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (org        . t)
     (shell      . t)
     (xml        . t)))
;; =org-babel= languages:1 ends here

;; [[file:README.org::*Bibtex][Bibtex:1]]
(use-package! bibtex-completion
  :config
  (setq bibtex-completion-notes-path   "~/git/phd/notes/"
        bibtex-completion-bibliography "~/Dropbox/org/research/zotLib.bib"
        bibtex-completion-library-path "~/Dropbox/org/research/zotero-library/"
        bibtex-completion-pdf-field    "file"
        bibtex-completion-additional-search-fields '(journal booktitle keywords)
        bibtex-completion-display-formats '((t . "${author:36} ${title:*} ${year:4} ${=has-pdf=:1}${=has-note=:1} ${=type=:7}"))
        bibtex-completion-notes-template-multiple-files
        (concat
         "#+TITLE: ${title}\n"
         "#+ROAM_KEY: cite:${=key=}\n"
         "* TODO Notes\n"
         ":PROPERTIES:\n"
         ":CUSTOM_ID: ${=key=}\n"
         ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
         ":AUTHOR: ${author-abbrev}\n"
         ":JOURNAL: ${journaltitle}\n"
         ":DATE: ${date}\n"
         ":YEAR: ${year}\n"
         ":DOI: ${doi}\n"
         ":URL: ${url}\n"
         ":END:\n\n")))
;; Bibtex:1 ends here

;; [[file:README.org::*Basic Config][Basic Config:1]]
(setq org-roam-directory        "~/git/phd/notes/")
(setq org-roam-db-update-method 'immediate)
(add-hook! 'org-roam-mode-hook #'org-roam-db-build-cache)
;; Basic Config:1 ends here

;; [[file:README.org::*Org Roam Bibtex][Org Roam Bibtex:1]]
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
           :head ,(concat
                   "#+TITLE: ${citekey}: ${title}\n"
                   "#+ROAM_KEY: ${ref}\n\n"
                   "* ${title}\n"
                   ":PROPERTIES:\n"
                   ":CUSTOM_ID: ${citekey}\n"
                   ":URL: ${url}\n"
                   ":AUTHOR: ${author}\n"
                   ":NOTER_DOCUMENT: %(orb-process-file-field \"${citekey}\")\n"
                   ":NOTER_PAGE:\n"
                   ":END:\n")
           :unnarrowed t))))
;; Org Roam Bibtex:1 ends here

;; [[file:README.org::*Org Noter][Org Noter:1]]
(after! org-noter
  (setq org-noter-notes-search-path (list "~/git/phd/notes/")))
;; Org Noter:1 ends here

;; [[file:README.org::*Pandoc][Pandoc:1]]
(use-package! ox-pandoc
  :after org)
;; default options for all output formats
(setq org-pandoc-options          '((standalone . _))
      org-pandoc-options-for-docx '((standalone . nil)))
;; Pandoc:1 ends here

;; [[file:README.org::*Zen-mode][Zen-mode:1]]
(setq +zen-text-scale 0.25)
;; Zen-mode:1 ends here

;; [[file:README.org::*PDF Tools][PDF Tools:1]]
(setq-default pdf-view-display-size 'fit-width)
(setq pdf-annot-activate-created-annotations t
      pdf-view-resize-factor 1.01)
;; PDF Tools:1 ends here
