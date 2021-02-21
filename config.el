;; [[file:README.org::*Lexical Bindings][Lexical Bindings:1]]
;;; config.el -*- lexical-binding: t; -*-
;; Lexical Bindings:1 ends here

;; [[file:README.org::*Better Defaults][Better Defaults:1]]
(global-auto-revert-mode 1)
(whitespace-mode -1)
(setq inhibit-compacting-font-caches t
      undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t
      global-subword-mode 1)
(setq-default delete-by-moving-to-trash t
              tab-width 4
              uniquify-buffer-name-style 'forward
              window-combination-resize t
              x-stretch-cursor nil)
;; Better Defaults:1 ends here

;; [[file:README.org::*=custom.el=][=custom.el=:1]]
(setq-default custom-file (expand-file-name ".custom.el" doom-private-dir))
(when (file-exists-p custom-file)
  (load custom-file))
;; =custom.el=:1 ends here

;; [[file:README.org::*=utf-8-unix= System][=utf-8-unix= System:1]]
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8)
;; =utf-8-unix= System:1 ends here

;; [[file:README.org::*Fonts][Fonts:1]]
(setq inhibit-compacting-font-caches t)
(setq doom-font                (font-spec :family "JetBrainsMono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "Alegreya" :weight 'semibold :size 21)
      doom-unicode-font        (font-spec :family "DejaVuSansMono Nerd Font"))
;; Fonts:1 ends here

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

;; [[file:README.org::*Show time][Show time:1]]
(setq display-time-24hr-format t)
(display-time-mode 1)
;; Show time:1 ends here

;; [[file:README.org::*Remove default load average][Remove default load average:1]]
(setq-default display-time-default-load-average nil
              display-time-load-average nil)
;; Remove default load average:1 ends here

;; [[file:README.org::*Hide =utf-8-unix= if not needed][Hide =utf-8-unix= if not needed:1]]
(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)
;; Hide =utf-8-unix= if not needed:1 ends here

;; [[file:README.org::*Adjust roam numbers][Adjust roam numbers:1]]
(defadvice! doom-modeline--buffer-file-name-roam-aware-a (orig-fun)
  :around #'doom-modeline-buffer-file-name ; takes no args
  (if (s-contains-p org-roam-directory (or buffer-file-name ""))
      (replace-regexp-in-string
       "\\(?:^\\|.*/\\)\\([0-9]\\{4\\}\\)\\([0-9]\\{2\\}\\)\\([0-9]\\{2\\}\\)[0-9]*-"
       "🢔(\\1-\\2-\\3) "
       (subst-char-in-string ?_ ?  buffer-file-name))
    (funcall orig-fun)))
;; Adjust roam numbers:1 ends here

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

;; [[file:README.org::*Global Substitute][Global Substitute:1]]
(setq evil-ex-substitute-global t)
;; Global Substitute:1 ends here

;; [[file:README.org::*Key delay][Key delay:1]]
(setq which-key-idle-delay 0.5)
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

;; [[file:README.org::*Ivy][Ivy:1]]
(setq ivy-read-action-function #'ivy-hydra-read-action
      ivy-sort-max-size 50000)
;; Ivy:1 ends here

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

;; [[file:README.org::*Window Navigation][Window Navigation:1]]
(map!
 :leader
 :desc "Switch to Left Window"  "<left>"  #'evil-window-left
 :desc "Switch to Right Window" "<right>" #'evil-window-right)
;; Window Navigation:1 ends here

;; [[file:README.org::*Window Split][Window Split:1]]
(setq evil-vsplit-window-right t
      evil-split-window-below  t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)
;; Window Split:1 ends here

;; [[file:README.org::*Company mode][Company mode:1]]
(after! company
  (setq company-idle-delay nil
        company-minimum-prefix-length 2
        company-show-numbers t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort)
  (setq-default history-length 1000)
  (setq-default prescient-history-length 1000))
;; Company mode:1 ends here

;; [[file:README.org::*Defaults][Defaults:1]]
(setq org-directory "~/git/org/"
      org-startup-folded 'overview
      org-use-property-inheritance t
      org-log-done 'time
      org-list-allow-alphabetical t
      org-export-in-background t
      org-catch-invisible-edits 'smart
      org-cycle-separator-lines  0)
      ;org-attach-id-dir (concat org-roam-directory "data/"))


;; Ignore org default template
;(set-file-template! "\\.org$" :ignore t)

;; Org block templates
(setq org-structure-template-alist
      '(("e" . "src emacs-lisp")
        ("p" . "src python")))
;; Defaults:1 ends here

;; [[file:README.org::*Org Defaults][Org Defaults:1]]
(setq org-startup-indented t
      org-fontify-quote-and-verse-blocks t)
;; Org Defaults:1 ends here

;; [[file:README.org::*Mixed Pitch Mode][Mixed Pitch Mode:1]]
;(add-hook! 'org-mode-hook #'+org-pretty-mode)
(add-hook! 'org-mode-hook #'mixed-pitch-mode)
(setq mixed-pitch-set-height t)
;; Mixed Pitch Mode:1 ends here

;; [[file:README.org::*Pretty tables][Pretty tables:1]]
(setq global-org-pretty-table-mode t)
;; Pretty tables:1 ends here

;; [[file:README.org::*Headings][Headings:1]]
(after! org
  (custom-set-faces!
    '(org-level-1 :height 1.15 :inherit outline-1)
    '(org-level-2 :height 1.13 :inherit outline-2)
    '(org-level-3 :height 1.11 :inherit outline-3)
    '(org-level-4 :height 1.09 :inherit outline-4)
    '(org-level-5 :height 1.07 :inherit outline-5)
    '(org-level-6 :height 1.05 :inherit outline-6)
    '(org-level-7 :height 1.03 :inherit outline-7)
    '(org-level-8 :height 1.01 :inherit outline-8)))

(after! org
  (custom-set-faces!
    '(org-document-title :height 1.15)))
;; Headings:1 ends here

;; [[file:README.org::*Show /empahsis/ markers][Show /empahsis/ markers:1]]
(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-hide-emphasis-markers t)
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil))
;; Show /empahsis/ markers:1 ends here

;; [[file:README.org::*Bullets / Endings][Bullets / Endings:1]]
(after! org-superstar
  (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        org-superstar-prettify-item-bullets t ))

(setq org-ellipsis " ▾ "
      org-hide-leading-stars t)
;      org-priority-highest ?A
;      org-priority-lowest ?E
;      org-priority-faces
;      '((?A . 'all-the-icons-red)
;        (?B . 'all-the-icons-orange)
;        (?C . 'all-the-icons-yellow)
;        (?D . 'all-the-icons-green)
;        (?E . 'all-the-icons-blue)))
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

;; [[file:README.org::*=org-babel= python][=org-babel= python:1]]
(setq org-babel-python-command "python3")

(defun cpkx/org-python ()
  (if (eq major-mode 'python-mode)
      (progn (anaconda-mode t)
             (company-mode t))))
(add-hook 'org-src-mode-hook 'cpkx/org-python)
;; =org-babel= python:1 ends here

;; [[file:README.org::*Bibtex][Bibtex:1]]
(use-package! bibtex-completion
  :config
  (setq bibtex-completion-notes-path   "~/git/phd/notes/"
        bibtex-completion-bibliography "~/Dropbox/research/zotLib.bib"
        bibtex-completion-library-path "~/Dropbox/research/zotero-library/"
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

;; [[file:README.org::*Org-Ref][Org-Ref:1]]
(use-package! org-ref
  :after org
  :config
  (setq org-ref-default-bibliography '("~/Dropbox/research/zotLib.bib")
        org-ref-completion-library 'org-ref-ivy-cite))
;; Org-Ref:1 ends here

;; [[file:README.org::*Basic Config][Basic Config:1]]
(after! org-roam
  (setq org-roam-directory        "~/git/phd/notes/"
        org-roam-db-update-method 'immediate
        +org-roam-open-buffer-on-find-file nil
        org-roam-buffer-width 0.25)
  (set-company-backend! 'org-mode 'company-capf)
  (add-hook! 'org-roam-mode-hook #'org-roam-db-build-cache))
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
  (setq org-noter-always-create-frame t
        org-noter-doc-split-fraction '(0.65 . 0.35)
        org-noter-separate-notes-from-heading t
        org-noter-auto-save-last-location t
        org-noter-doc-property-in-notes t
        org-noter-notes-search-path (list "~/git/phd/notes/")))
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
