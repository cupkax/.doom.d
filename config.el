;;; config.el -*- lexical-binding: t; -*-

(global-auto-revert-mode 1)
(whitespace-mode -1)
(setq inhibit-compacting-font-caches t
      undo-limit 80000000
      load-prefer-newer t
      evil-want-fine-undo t
      auto-save-default t
      ;truncate-string-ellipsis "…"
      global-subword-mode 1)
(setq-default delete-by-moving-to-trash t
              tab-width 4
              uniquify-buffer-name-style 'forward
              window-combination-resize t
              x-stretch-cursor nil)

(setq-default custom-file (expand-file-name ".custom.el" doom-private-dir))
(when (file-exists-p custom-file)
  (load custom-file))

(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8)

(defun cpkx/fuckoff-macwin ()
  (let ((coding-str (symbol-name buffer-file-coding-system)))
    (when (string-match "-\\(?:dos\\|mac\\)$" coding-str)
      (set-buffer-file-coding-system 'unix))))

(add-hook 'find-file-hook 'cpkx/fuckoff-macwin)

(setq doom-font                (font-spec :family "JetBrainsMono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "Overpass"                :size 24)
      doom-unicode-font        (font-spec :family "JuliaMono"               :size 16)
      doom-serif-font          (font-spec :family "IBM Plex Mono"   :weight 'light))

(setq doom-theme 'doom-nord)
;(use-package circadian
;  :config
;  (setq circadian-themes '(("6:00"  . doom-nord)
;                           ("18:30" . doom-dracula)))
;  (circadian-setup))

(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))

(setq display-time-24hr-format t)
(display-time-mode 1)

(setq-default display-time-default-load-average nil
              display-time-load-average nil)

(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(setq display-line-numbers-type nil)

(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)

(general-auto-unbind-keys)

(setq evil-move-beyond-eol t)

(setq evil-ex-substitute-global t)

(setq doom-localleader-key ",")

(setq which-key-idle-delay 0.15)

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
      (setq deft-directory "~/git/org/"))

(setq ivy-read-action-function #'ivy-hydra-read-action
      ivy-sort-max-size 50000)

(map!
 :leader
 :desc "Switch to Left Window"  "<left>"    #'evil-window-left
 :desc "Switch to Right Window" "<right>"   #'evil-window-right
 :desc "Switch to Up Window"    "<up>"      #'evil-window-up
 :desc "Switch to Down Window"  "<down>"    #'evil-window-down)

(setq evil-vsplit-window-right t
      evil-split-window-below  t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

(after! company
  (setq company-idle-delay 0
        company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort))
(setq-default history-length 1000)
(setq-default prescient-history-length 1000)
;(set-company-backend!
;  '(text-mode
;    markdown-mode
;    gfm-mode)
;  '(:seperate
;    company-ispell
;    company-files
;    company-yasnippet))
;(set-company-backend! 'org-mode '(company-yasnippet company-capf company-files company-elisp))
;(set-company-backend! 'emacs-lisp-mode '(company-yasnippet company-elisp))
;(add-to-list 'company-backends '(company-capf company-files company-yasnippet company-semantic company-bbdb company-cmake company-keywords))

(setq org-directory "~/git/org/"
      org-startup-folded 'overview
      org-use-property-inheritance t
      org-log-done 'time
      org-list-allow-alphabetical t
      org-export-in-background t
      org-export-with-sub-superscripts '{}        ; don't treat lone _ / ^ as sub/superscripts, require _{} / ^{}
      org-catch-invisible-edits 'smart
      org-cycle-separator-lines  0)

;; Ignore org default template
(set-file-template! "\\.org$" :ignore t)

;; Org block templates
(setq org-structure-template-alist
      '(("e" . "src emacs-lisp")))

;Keymap
(map! :map evil-org-mode-map
      :after evil-org
      :n "g <up>" #'org-backward-heading-same-level
      :n "g <down>" #'org-forward-heading-same-level
      :n "g <left>" #'org-up-element
      :n "g <right>" #'org-down-element)

(setq org-fontify-quote-and-verse-blocks t
      org-hide-emphasis-markers t)

(custom-set-faces!
  '(outline-1 :weight extra-bold :height 1.1)
  '(outline-2 :weight bold       :height 1.09)
  '(outline-3 :weight bold       :height 1.07)
  '(outline-4 :weight semi-bold  :height 1.05)
  '(outline-5 :weight semi-bold  :height 1.03)
  '(outline-6 :weight semi-bold  :height 1.01)
  '(outline-7 :weight semi-bold  :height 1.01)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold))

(custom-set-faces!
  '(org-document-title :height 1.20))

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil))

(defun locally-defer-font-lock ()
  "Set jit-lock defer and stealth, when buffer is over a certain size."
  (when (> (buffer-size) 50000)
    (setq-local jit-lock-defer-time 0.05
                jit-lock-stealth-time 1)))

(add-hook 'org-mode-hook #'locally-defer-font-lock)

(after! org-superstar
  (setq org-superstar-headline-bullets-list '("🞅" "🞊" "✠" "🟅" "🞜" "🟉" "◆")
        org-superstar-prettify-item-bullets t
        org-superstar-remove-leading-stars t)

(setq org-ellipsis " ▾ "
      org-hide-leading-stars t)
      org-priority-highest ?A
      org-priority-lowest ?E
      org-priority-faces
      '((?A . 'all-the-icons-red)
        (?B . 'all-the-icons-orange)
        (?C . 'all-the-icons-yellow)
        (?D . 'all-the-icons-green)
        (?E . 'all-the-icons-blue)))

;Change list bullets with depth
(setq org-list-demote-modify-bullet '(("+" . "-")
                                      ("-" . "+")
                                      ("*" . "+")
                                      ("1." . "a.")))

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

(defadvice! shut-up-org-problematic-hooks (orig-fn &rest args)
  :around #'org-fancy-priorities-mode
  :around #'org-superstar-mode
  (ignore-errors (apply orig-fn args)))

(use-package! bibtex-completion
  :config
  (setq bibtex-completion-notes-path   "~/git/org/roam/"
        bibtex-completion-bibliography "~/Dropbox/research/zotLib.bib"
        bibtex-completion-library-path "~/Dropbox/research/zotero-library/"
        bibtex-completion-pdf-field    "file"
        bibtex-completion-additional-search-fields '(journal booktitle keywords)
        bibtex-completion-display-formats '((t . "${author:36} ${title:*} ${year:4} ${=has-pdf=:1}${=has-note=:1} ${=type=:7}"))
        bibtex-completion-notes-template-multiple-files
        (concat
         "#+title: ${title}\n"
         "#+roam_key: cite:${=key=}\n"
         "* TODO Notes\n"
         ":PROPERTIES:\n"
         ":Custom_ID: ${=key=}\n"
         ":AUTHOR: ${author-abbrev}\n"
         ":JOURNAL: ${journaltitle}\n"
         ":DATE: ${date}\n"
         ":YEAR: ${year}\n"
         ":DOI: ${doi}\n"
         ":URL: ${url}\n"
         ":END:\n\n")))

(use-package! doct
  :commands (doct))

(after! org-capture
  (setq org-capture-templates
        (doct `(("PhD" :keys "p"
                 :file "~/git/org/PhD.org"
                 :prepend t
                 :headline "PhD"
                 :type entry
                 :children (("Meeting" :keys "m"
                             :template ("* TODO %u"
                                        "%i"))
                            ("Miscellaneous Tasks" :keys "t"
                             :template ("* TODO %^{task}"
                                        "DEADLINE: %^{do by}t"
                                        "%i"))
                            )
                 )

                ("Email" :keys "e"
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "Inbox"
                   :type entry
                   :template ("* TODO %^{type|reply to|contact} %\\3 %? :email:"
                              "Send an email %^{ASAP|soon|eventually} to %^{recipiant}"
                              " %^{topic}"
                              "%i"))
                  ))))

(after! org-roam
  (setq org-roam-directory "~/git/org/roam/"
        org-roam-tag-sources '(prop all-directories)
        org-roam-link-file-path-type 'relative
        +org-roam-open-buffer-on-find-file nil
        org-roam-completion-everywhere nil
        org-roam-buffer-width 0.25
        org-roam-db-update-method 'immediate)
  (add-hook! 'org-roam-mode-hook #'org-roam-db-build-cache)
  (defun cpkx/org-roam-prompt-tags ()
  "Prompt user and ask if they want to input roam_tags during capture."
  (when (y-or-n-p "Add tags? ")
    (insert (format "%s" "\n#+roam_tags: ")))))

(use-package! ox-pandoc
  :after org)
;; default options for all output formats
(setq org-pandoc-options          '((standalone . _))
      org-pandoc-options-for-docx '((standalone . nil)))

(use-package! org-pandoc-import
  :after org)

(defun org-syntax-convert-keyword-case-to-lower ()
  "Convert all #+KEYWORDS to #+keywords."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((count 0)
          (case-fold-search nil))
      (while (re-search-forward "^[ \t]*#\\+[A-Z_]+" nil t)
        (unless (s-matches-p "RESULTS" (match-string 0))
          (replace-match (downcase (match-string 0)) t)
          (setq count (1+ count))))
      (message "Replaced %d occurances" count))))

(autoload #'mixed-pitch-serif-mode "mixed-pitch"
  "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch." t)

(after! mixed-pitch
  (defface variable-pitch-serif
    '((t (:family "serif")))
    "A variable-pitch face with serifs."
    :group 'basic-faces)
  (setq mixed-pitch-set-height t)
  (setq variable-pitch-serif-font (font-spec :family "Alegreya" :size 21 :weight 'semi-bold))
  (set-face-attribute 'variable-pitch-serif nil :font variable-pitch-serif-font)
  (defun mixed-pitch-serif-mode (&optional arg)
    "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch."
    (interactive)
    (let ((mixed-pitch-face 'variable-pitch-serif))
      (mixed-pitch-mode (or arg 'toggle)))))

(set-char-table-range composition-function-table ?f '(["\\(?:ff?[fijlt]\\)" 0 font-shape-gstring]))
(set-char-table-range composition-function-table ?T '(["\\(?:Th\\)" 0 font-shape-gstring]))



(add-hook! 'org-mode-hook #'mixed-pitch-mode)
;(add-hook! 'text-mode-hook #'mixed-pitch-mode)

(setq +zen-text-scale 0.25)
(defvar +zen-serif-p t
  "Whether to use a serifed font with `mixed-pitch-mode'.")
(after! writeroom-mode
  (defvar-local +zen--original-org-indent-mode-p nil)
  (defvar-local +zen--original-mixed-pitch-mode-p nil)
  ;(defvar-local +zen--original-org-pretty-table-mode-p nil)
  (defun +zen-enable-mixed-pitch-mode-h ()
    "Enable `mixed-pitch-mode' when in `+zen-mixed-pitch-modes'."
    (when (apply #'derived-mode-p +zen-mixed-pitch-modes)
      (if writeroom-mode
          (progn
            (setq +zen--original-mixed-pitch-mode-p mixed-pitch-mode)
            (funcall (if +zen-serif-p #'mixed-pitch-serif-mode #'mixed-pitch-mode) 1))
        (funcall #'mixed-pitch-mode (if +zen--original-mixed-pitch-mode-p 1 -1)))))
  (pushnew! writeroom--local-variables
            'visual-fill-column-width
            'org-adapt-indentation)
  (add-hook 'writeroom-mode-enable-hook
            (defun +zen-prose-org-h ()
              "Reformat the current Org buffer appearance for prose."
              (when (eq major-mode 'org-mode)
                (setq visual-fill-column-width 80
                      org-adapt-indentation nil
                      adaptive-wrap-prefix-mode 1)
                (add-hook! 'org-mode-hook 'adaptive-wrap-prefix-mode 'turn-off-auto-fill)
                ;(add-hook! 'org-mode-hook 'visual-fill-column-mode)
                (setq
                 +zen--original-org-indent-mode-p org-indent-mode)
                 ;+zen--original-org-pretty-table-mode-p (bound-and-true-p org-pretty-table-mode))
                (org-indent-mode -1))))
                ;(org-pretty-table-mode 1))))
  (add-hook 'writeroom-mode-disable-hook
            (defun +zen-nonprose-org-h ()
              "Reverse the effect of `+zen-prose-org'."
              (when (eq major-mode 'org-mode)
                (when +zen--original-org-indent-mode-p (org-indent-mode 1))
                ))))

(cond ((executable-find "enchant-2")  (setq-default ispell-program-name "enchant-2"))
      ((executable-find "hunspell")   (progn (setq-default ispell-program-name "hunspell") (setq ispell-really-hunspell t)))
      ((executable-find "aspell")     (setq-default ispell-program-name "aspell")))
(setenv
  "DICPATH"
  (concat (getenv "HOME") "/Library/Spelling"))
(setenv "LANG" "en-custom")
(setq ispell-dictionary "en-custom")
;(setq company-ispell-dictionary "en-custom")
;(setq ispell-alternate-dictionary "en-custom")
(setq ispell-local-dictionary-alist
      '(("en-custom" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil nil nil utf-8)))
;(setq ispell-alternate-dictionary
;     '(("en-custom" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil nil nil utf-8)))

(defun rsync-drop ()
  ;(setq shell-file-name "c:/msys64/usr/bin/bash.exe")
  (shell-command "rsync -avu --delete $HOME/git/org/ $HOME/Dropbox/org/"))

(add-hook! 'after-save-hook 'rsync-drop)
(add-hook! 'kill-emacs-hook 'rsync-drop)
