;; [[file:README.org::*Lexical Bindings][Lexical Bindings:1]]
;;; config.el -*- lexical-binding: t; -*-
;; Lexical Bindings:1 ends here

;; [[file:README.org::*Personal Information][Personal Information:1]]
(setq user-full-name "Vedant Sansare (cupkax)"
      user-mail-address "vedantsansare23@gmail.com")
;; Personal Information:1 ends here

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
(setq doom-font                (font-spec :family "FiraCode Nerd Font" :size 16))
(setq doom-big-font            (font-spec :family "FiraCode Nerd Font" :size 20))
(setq doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :size 16))
(setq doom-serif-font          (font-spec :family "BlexMono Nerd Font" :weight 'light))
;; Fonts:1 ends here

;; [[file:README.org::*Theme][Theme:1]]
(setq doom-theme 'doom-palenight)
;; Theme:1 ends here

;; [[file:README.org::*Line Numbers][Line Numbers:1]]
(setq display-line-numbers-type 'relative)
;; Line Numbers:1 ends here

;; [[file:README.org::*Change red text][Change red text:1]]
(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "grey"))
;; Change red text:1 ends here

;; [[file:README.org::*Show time][Show time:1]]
(setq display-time-24hr-format t)
(display-time-mode 1)
;; Show time:1 ends here

;; [[file:README.org::*Debug][Debug:1]]
(custom-set-faces! '(doom-modeline-evil-insert-state :weight bold :foreground "#339CDB"))
;; Debug:1 ends here

;; [[file:README.org::*Filename][Filename:1]]
(defadvice! doom-modeline--buffer-file-name-roam-aware-a (orig-fun)
  :around #'doom-modeline-buffer-file-name ; takes no args
  (if (s-contains-p org-roam-directory (or buffer-file-name ""))
      (replace-regexp-in-string
       "\\(?:^\\|.*/\\)\\([0-9]\\{4\\}\\)\\([0-9]\\{2\\}\\)\\([0-9]\\{2\\}\\)[0-9]*-"
       "(\\1-\\2-\\3) "
       (subst-char-in-string ?_ ?  buffer-file-name))
    (funcall orig-fun)))
;; Filename:1 ends here

;; [[file:README.org::*Info Colors][Info Colors:1]]
(use-package! info-colors
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

(add-hook 'Info-mode-hook #'mixed-pitch-mode)
;; Info Colors:1 ends here

;; [[file:README.org::*Global Substitution][Global Substitution:1]]
(after! evil (setq evil-ex-substitute-global t))
;; Global Substitution:1 ends here

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

;; [[file:README.org::*Ivy][Ivy:1]]
(setq ivy-read-action-function #'ivy-hydra-read-action)
(setq ivy-sort-max-size 50000)
;; Ivy:1 ends here

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

;; [[file:README.org::*Window Title][Window Title:1]]
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
;; Window Title:1 ends here

;; [[file:README.org::*Window Management][Window Management:1]]
(map! :map evil-window-map
      "SPC" #'rotate-layout
      ;; Navigation
      "<left>"         #'evil-window-left
      "<down>"         #'evil-window-down
      "<up>"           #'evil-window-up
      "<right>"        #'evil-window-right
      ;; Swapping windows
      "C-<left>"       #'+evil/window-move-left
      "C-<down>"       #'+evil/window-move-down
      "C-<up>"         #'+evil/window-move-up
      "C-<right>"      #'+evil/window-move-right)
;; Window Management:1 ends here

;; [[file:README.org::*Window Split][Window Split:1]]
(setq evil-vsplit-window-right t
      evil-split-window-below  t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))

(setq +ivy-buffer-preview t)
;; Window Split:1 ends here

;; [[file:README.org::*Window Resize][Window Resize:1]]
(setq-default window-combination-resize t)
;; Window Resize:1 ends here

;; [[file:README.org::*Company mode][Company mode:1]]
(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2
        company-show-numbers t)
  (setq-default history-length 1000)
  (setq-default prescient-history-length 1000))
;; Company mode:1 ends here

;; [[file:README.org::*Parentheses][Parentheses:1]]
(sp-local-pair
 '(org-mode)
 "<<" ">>"
 :actions '(insert))
;; Parentheses:1 ends here

;; [[file:README.org::*Dictionary][Dictionary:1]]
(setq ispell-dictionary "en-custom")
(setq ispell-personal-dictionary (expand-file-name ".ispell_personal" doom-private-dir))
;; Dictionary:1 ends here

;; [[file:README.org::*Spellcheck][Spellcheck:1]]
(add-hook 'org-mode-hook 'turn-on-flyspell)

(defun my-save-word ()
  (interactive)
  (let ((current-location (point))
         (word (flyspell-get-word)))
    (when (consp word)
      (flyspell-do-correct 'save nil (car word) current-location (cadr word) (caddr word) current-location))))
;; Spellcheck:1 ends here

;; [[file:README.org::*Plain Text][Plain Text:1]]
(set-company-backend!
  '(text-mode
    markdown-mode
    gfm-mode)
  '(:seperate
    company-ispell
    company-files
    company-yasnippet))

(after! text-mode
  (add-hook! 'text-mode-hook
             ;; Apply ANSI color codes
             (with-silent-modifications
               (ansi-color-apply-on-region (point-min) (point-max)))))
;; Plain Text:1 ends here

;; [[file:README.org::*YASnippet][YASnippet:1]]
(setq yas-triggers-in-field t)
;; YASnippet:1 ends here

;; [[file:README.org::*Development][Development:1]]
(defvar org-ml-target-dir "~/.emacs.d/.local/straight/repos/org-mode/")
(defvar org-ml-max-age 600
  "Maximum permissible age in seconds.")
(defvar org-ml--cache-timestamp 0)
(defvar org-ml--cache nil)

(defun org-ml-current-patches ()
  "Get the currently open patches, as a list of alists.
Entries of the form (subject . id)."
  (delq nil
        (mapcar
         (lambda (entry)
           (unless (plist-get entry :fixed)
             (cons
              (format "%-8s  %s"
                      (propertize
                       (replace-regexp-in-string "T.*" ""
                                                 (plist-get entry :date))
                       'face 'font-lock-doc-face)
                      (propertize
                       (replace-regexp-in-string "\\[PATCH\\] ?" ""
                                                 (plist-get entry :summary))
                       'face 'font-lock-keyword-face))
              (plist-get entry :id))))
         (with-current-buffer (url-retrieve-synchronously "https://updates.orgmode.org/data/patches")
           (json-parse-buffer :object-type 'plist)))))

(defun org-ml-select-patch-thread ()
  "Find and apply a proposed Org patch."
  (interactive)
  (let ((current-workspace (+workspace-current))
        (patches (progn
                   (when (or (not org-ml--cache)
                             (> (- (float-time) org-ml--cache-timestamp)
                                org-ml-max-age))
                     (setq org-ml--cache (org-ml-current-patches)
                           org-ml--cache-timestamp (float-time)))
                   org-ml--cache))
        msg-id)
    (ivy-read "Thread: "
              patches
              :action (lambda (m) (setq msg-id (cdr m))))
    (+workspace-switch +mu4e-workspace-name)
    (mu4e-view-message-with-message-id msg-id)
    (add-to-list 'mu4e-view-actions
                 (cons "apply patch to org" #'org-ml-transient-mu4e-action))))

(defun org-ml-transient-mu4e-action (msg)
  (setq mu4e-view-actions
        (delete (cons "apply patch to org" #'org-ml-transient-mu4e-action)
                mu4e-view-actions))
  (+workspace/other)
  (magit-status org-ml-target-dir)
  (with-current-buffer (get-buffer-create "*Shell: Org apply patches*")
    (erase-buffer)
    (let ((default-directory org-ml-target-dir))
      (shell-command
       (format "git am %s"
               (shell-quote-argument (mu4e-message-field msg :path)))
       (current-buffer))
      (magit-refresh))
    (when (string-match-p "Error\\|failed" (buffer-string))
      (+popup/buffer))))
;; Development:1 ends here

;; [[file:README.org::*Defaults][Defaults:1]]
(setq-default major-mode 'org-mode)
(setq org-directory                     "~/git/phd/notes/"
      org-use-property-inheritance      t
      org-log-done                      'time
      org-list-allow-alphabetical       t
      org-export-in-background          t
      org-catch-invisible-edits         'smart
      org-cycle-separator-lines              0)

(setq org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a.")))
;; Defaults:1 ends here

;; [[file:README.org::*Babel][Babel:1]]
(setq org-babel-default-header-args
      '((:session  . "none")
        (:results  . "replace")
        (:exports  . "code")
        (:cache    . "no")
        (:noweb    . "no")
        (:hlines   . "no")
        (:tangle   . "no")
        (:comments . "link")))
;; Babel:1 ends here

;; [[file:README.org::*Keybinds][Keybinds:1]]
(map! :map evil-org-mode-map
      :after evil-org
      :n "g <up>"    #'org-backward-heading-same-level
      :n "g <down>"  #'org-forward-heading-same-level
      :n "g <left>"  #'org-up-element
      :n "g <right>" #'org-down-element
      )
;; Keybinds:1 ends here

;; [[file:README.org::*LSP Support][LSP Support:1]]
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
(defvar org-babel-lang-list
  '("go" "python" "ipython" "bash" "sh"))
(dolist (lang org-babel-lang-list)
  (eval `(lsp-org-babel-enable ,lang)))
;; LSP Support:1 ends here

;; [[file:README.org::*Org Agenda][Org Agenda:1]]
(use-package! org-super-agenda
  :commands (org-super-agenda-mode))
(after! org-agenda
  (org-super-agenda-mode))

(setq
 org-agenda-include-deadlines t
 org-agenda-tags-column 100
 org-agenda-compact-blocks t)

(setq org-agenda-custom-commands
      '(("o" "Overview"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today"
                          :time-grid t
                          :date today
                          :todo "TODAY"
                          :scheduled today
                          :order 1)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Next to do"
                           :todo "NEXT"
                           :order 1)
                          (:name "Important"
                           :tag "Important"
                           :priority "A"
                           :order 6)
                          (:name "Due Today"
                           :deadline today
                           :order 2)
                          (:name "Due Soon"
                           :deadline future
                           :order 8)
                          (:name "Overdue"
                           :deadline past
                           :face error
                           :order 7)
                          (:name "Assignments"
                           :tag "Assignment"
                           :order 10)
                          (:name "Issues"
                           :tag "Issue"
                           :order 12)
                          (:name "Emacs"
                           :tag "Emacs"
                           :order 13)
                          (:name "Projects"
                           :tag "Project"
                           :order 14)
                          (:name "Research"
                           :tag "Research"
                           :order 15)
                          (:name "To read"
                           :tag "Read"
                           :order 30)
                          (:name "Waiting"
                           :todo "WAITING"
                           :order 20)
                          (:name "University"
                           :tag "uni"
                           :order 32)
                          (:name "Trivial"
                           :priority<= "E"
                           :tag ("Trivial" "Unimportant")
                           :todo ("SOMEDAY" )
                           :order 90)
                          (:discard (:tag ("Chore" "Routine" "Daily")))))))))))
;; Org Agenda:1 ends here

;; [[file:README.org::*Basic Config][Basic Config:1]]
(setq org-roam-directory        "~/git/phd/notes/")
(setq org-roam-db-update-method 'immediate)
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
;; Org Roam Bibtex:1 ends here

;; [[file:README.org::*Helm Bibtex][Helm Bibtex:1]]
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
;; Helm Bibtex:1 ends here

;; [[file:README.org::*Org Noter][Org Noter:1]]
(setq
 org-noter-hide-other nil
 org-noter-notes-search-path (list "~/git/phd/notes/"))
;; Org Noter:1 ends here

;; [[file:README.org::*Pandoc][Pandoc:1]]
(use-package! ox-pandoc
  :after org)
;; default options for all output formats
(setq org-pandoc-options '((standalone . _)))
;; cancel above settings only for 'docx' format
(setq org-pandoc-options-for-docx '((standalone . nil)))
;; special extensions for markdown_github output
(setq org-pandoc-format-extensions '(markdown_github+pipe_tables+raw_html))
;; Pandoc:1 ends here

;; [[file:README.org::*PDF Tools][PDF Tools:1]]
(after! pdf-view
  (setq-default pdf-view-display-size 'fit-width)
  (setq pdf-annot-activate-created-annotations t
        pdf-view-resize-factor 1.1))
;; PDF Tools:1 ends here
