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

(defun cpkx/fuckoff-macwin ()
  (let ((coding-str (symbol-name buffer-file-coding-system)))
    (when (string-match "-\\(?:dos\\|mac\\)$" coding-str)
      (set-buffer-file-coding-system 'unix))))

(add-hook 'find-file-hook 'cpkx/fuckoff-macwin)
;; =utf-8-unix= System:1 ends here

;; [[file:README.org::*Fonts][Fonts:1]]
(setq doom-font                (font-spec :family "JetBrainsMono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "Overpass"                :size 24)
      doom-unicode-font        (font-spec :family "JuliaMono"               :size 16)
      doom-serif-font          (font-spec :family "IBM Plex Mono"   :weight 'light))
;; Fonts:1 ends here

;; [[file:README.org::*Theme][Theme:1]]
(setq doom-theme 'doom-nord)
;(use-package circadian
;  :config
;  (setq circadian-themes '(("6:00"  . doom-nord)
;                           ("18:30" . doom-dracula)))
;  (circadian-setup))
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

;; [[file:README.org::*Line Numbers][Line Numbers:1]]
(setq display-line-numbers-type nil)
;; Line Numbers:1 ends here

;; [[file:README.org::*HL-Mode][HL-Mode:1]]
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)
;; HL-Mode:1 ends here

;; [[file:README.org::*Auto-unbind][Auto-unbind:1]]
(general-auto-unbind-keys)
;; Auto-unbind:1 ends here

;; [[file:README.org::*Move beyond eol][Move beyond eol:1]]
(setq evil-move-beyond-eol t)
;; Move beyond eol:1 ends here

;; [[file:README.org::*Global Substitute][Global Substitute:1]]
(setq evil-ex-substitute-global t)
;; Global Substitute:1 ends here

;; [[file:README.org::*Change local leader][Change local leader:1]]
(setq doom-localleader-key ",")
;; Change local leader:1 ends here

;; [[file:README.org::*Key delay][Key delay:1]]
(setq which-key-idle-delay 0.15)
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

;; [[file:README.org::*Window Navigation][Window Navigation:1]]
(map!
 :leader
 :desc "Switch to Left Window"  "<left>"    #'evil-window-left
 :desc "Switch to Right Window" "<right>"   #'evil-window-right
 :desc "Switch to Up Window"    "<up>"      #'evil-window-up
 :desc "Switch to Down Window"  "<down>"    #'evil-window-down)
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
  (setq company-idle-delay 0
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
;(set-company-backend! 'org-mode '(company-yasnippet company-capf company-files company-elisp))
;(set-company-backend! 'emacs-lisp-mode '(company-yasnippet company-elisp))
;(add-to-list 'company-backends '(company-capf company-files company-yasnippet company-semantic company-bbdb company-cmake company-keywords))
;; Company mode:1 ends here

;; [[file:README.org::*Defaults][Defaults:1]]
(setq org-directory "~/git/org/"
      org-startup-folded 'overview
      org-use-property-inheritance t
      org-log-done 'time
      org-list-allow-alphabetical t
      org-export-in-background t
      org-export-with-sub-superscripts '{}        ; don't treat lone _ / ^ as sub/superscripts, require _{} / ^{}
      org-catch-invisible-edits 'smart
      org-cycle-separator-lines  0)

;; For Tables
;(remove-hook 'text-mode-hook #'visual-line-mode)
;(add-hook 'text-mode-hook #'auto-fill-mode)

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
;; Defaults:1 ends here

;; [[file:README.org::*Org Defaults][Org Defaults:1]]
;(add-hook! 'org-mode-hook #'+org-pretty-mode)
(setq ;org-startup-indented nil
      ;org-adapt-indentation t
      org-fontify-quote-and-verse-blocks t
      org-hide-emphasis-markers t)
;; Org Defaults:1 ends here

;; [[file:README.org::*Headings][Headings:1]]
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
;; Headings:1 ends here

;; [[file:README.org::*Show /empahsis/ markers][Show /empahsis/ markers:1]]
(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil))
;; Show /empahsis/ markers:1 ends here

;; [[file:README.org::*Font Lock][Font Lock:1]]
(defun locally-defer-font-lock ()
  "Set jit-lock defer and stealth, when buffer is over a certain size."
  (when (> (buffer-size) 50000)
    (setq-local jit-lock-defer-time 0.05
                jit-lock-stealth-time 1)))

(add-hook 'org-mode-hook #'locally-defer-font-lock)
;; Font Lock:1 ends here

;; [[file:README.org::*Bullets / Endings][Bullets / Endings:1]]
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

;; [[file:README.org::*Fix visual hooks][Fix visual hooks:1]]
(defadvice! shut-up-org-problematic-hooks (orig-fn &rest args)
  :around #'org-fancy-priorities-mode
  :around #'org-superstar-mode
  (ignore-errors (apply orig-fn args)))
;; Fix visual hooks:1 ends here

;; [[file:README.org::*Src blocks fontification][Src blocks fontification:1]]
(defvar org-prettify-inline-results t
  "Whether to use (ab)use prettify-symbols-mode on {{{results(...)}}}.")

(defvar org-fontify-inline-src-blocks-max-length 200
  "Maximum content length of an inline src block that will be fontified.")

(defun org-fontify-inline-src-blocks (limit)
  "Try to apply `org-fontify-inline-src-blocks-1'."
  (condition-case nil
      (org-fontify-inline-src-blocks-1 limit)
    (error (message "Org mode fontification error in %S at %d"
                    (current-buffer)
                    (line-number-at-pos)))))

(defun org-fontify-inline-src-blocks-1 (limit)
  "Fontify inline src_LANG blocks, from `point' up to LIMIT."
  (let ((case-fold-search t))
    (when (re-search-forward "\\_<src_\\([^ \t\n[{]+\\)[{[]?" limit t) ; stolen from `org-element-inline-src-block-parser'
      (let ((beg (match-beginning 0))
            pt
            (lang-beg (match-beginning 1))
            (lang-end (match-end 1)))
        (remove-text-properties beg lang-end '(face nil))
        (font-lock-append-text-property lang-beg lang-end 'face 'org-meta-line)
        (font-lock-append-text-property beg lang-beg 'face 'shadow)
        (font-lock-append-text-property beg lang-end 'face 'org-block)
        (setq pt (goto-char lang-end))
        ;; `org-element--parse-paired-brackets' doesn't take a limit, so to
        ;; prevent it searching the entire rest of the buffer we temporarily
        ;; narrow the active region.
        (save-restriction
          (narrow-to-region beg (min (point-max) limit (+ lang-end org-fontify-inline-src-blocks-max-length)))
          (when (ignore-errors (org-element--parse-paired-brackets ?\[))
            (remove-text-properties pt (point) '(face nil))
            (font-lock-append-text-property pt (point) 'face 'org-block)
            (setq pt (point)))
          (when (ignore-errors (org-element--parse-paired-brackets ?\{))
            (remove-text-properties pt (point) '(face nil))
            (font-lock-append-text-property pt (1+ pt) 'face '(org-block shadow))
            (unless (= (1+ pt) (1- (point)))
              (if org-src-fontify-natively
                  (org-src-font-lock-fontify-block (buffer-substring-no-properties lang-beg lang-end) (1+ pt) (1- (point)))
                (font-lock-append-text-property (1+ pt) (1- (point)) 'face 'org-block)))
            (font-lock-append-text-property (1- (point)) (point) 'face '(org-block shadow))
            (setq pt (point))))
        (when (and org-prettify-inline-results (re-search-forward "\\= {{{results(" limit t))
          (font-lock-append-text-property pt (1+ pt) 'face 'org-block)
          (goto-char pt))))
    (when (and org-prettify-inline-results (re-search-forward "{{{results(\\(.+?\\))}}}" limit t))
      (remove-list-of-text-properties (match-beginning 0) (point)
                                      '(composition
                                        prettify-symbols-start
                                        prettify-symbols-end))
      (font-lock-append-text-property (match-beginning 0) (match-end 0) 'face 'org-block)
      (let ((start (match-beginning 0)) (end (match-beginning 1)))
        (with-silent-modifications
          (compose-region start end "⟨")
          (add-text-properties start end `(prettify-symbols-start ,start prettify-symbols-end ,end))))
      (let ((start (match-end 1)) (end (point)))
        (with-silent-modifications
          (compose-region start end "⟩")
          (add-text-properties start end `(prettify-symbols-start ,start prettify-symbols-end ,end)))))))

(defun org-fontify-inline-src-blocks-enable ()
  "Add inline src fontification to font-lock in Org.
Must be run as part of `org-font-lock-set-keywords-hook'."
  (setq org-font-lock-extra-keywords
        (append org-font-lock-extra-keywords '((org-fontify-inline-src-blocks)))))

(add-hook 'org-font-lock-set-keywords-hook #'org-fontify-inline-src-blocks-enable)
;; Src blocks fontification:1 ends here

;; [[file:README.org::*Org Return][Org Return:1]]
(defun unpackaged/org-element-descendant-of (type element)
  "Return non-nil if ELEMENT is a descendant of TYPE.
TYPE should be an element type, like `item' or `paragraph'.
ELEMENT should be a list like that returned by `org-element-context'."
  ;; MAYBE: Use `org-element-lineage'.
  (when-let* ((parent (org-element-property :parent element)))
    (or (eq type (car parent))
        (unpackaged/org-element-descendant-of type parent))))

;;;###autoload
(defun unpackaged/org-return-dwim (&optional default)
  "A helpful replacement for `org-return-indent'.  With prefix, call `org-return-indent'.

On headings, move point to position after entry content.  In
lists, insert a new item or end the list, with checkbox if
appropriate.  In tables, insert a new row or end the table."
  ;; Inspired by John Kitchin: http://kitchingroup.cheme.cmu.edu/blog/2017/04/09/A-better-return-in-org-mode/
  (interactive "P")
  (if default
      (org-return t)
    (cond
     ;; Act depending on context around point.

     ;; NOTE: I prefer RET to not follow links, but by uncommenting this block, links will be
     ;; followed.

     ;; ((eq 'link (car (org-element-context)))
     ;;  ;; Link: Open it.
     ;;  (org-open-at-point-global))

     ((org-at-heading-p)
      ;; Heading: Move to position after entry content.
      ;; NOTE: This is probably the most interesting feature of this function.
      (let ((heading-start (org-entry-beginning-position)))
        (goto-char (org-entry-end-position))
        (cond ((and (org-at-heading-p)
                    (= heading-start (org-entry-beginning-position)))
               ;; Entry ends on its heading; add newline after
               (end-of-line)
               (insert "\n\n"))
              (t
               ;; Entry ends after its heading; back up
               (forward-line -1)
               (end-of-line)
               (when (org-at-heading-p)
                 ;; At the same heading
                 (forward-line)
                 (insert "\n")
                 (forward-line -1))
               ;; FIXME: looking-back is supposed to be called with more arguments.
               (while (not (looking-back (rx (repeat 3 (seq (optional blank) "\n")))))
                 (insert "\n"))
               (forward-line -1)))))

     ((org-at-item-checkbox-p)
      ;; Checkbox: Insert new item with checkbox.
      (org-insert-todo-heading nil))

     ((org-in-item-p)
      ;; Plain list.  Yes, this gets a little complicated...
      (let ((context (org-element-context)))
        (if (or (eq 'plain-list (car context))  ; First item in list
                (and (eq 'item (car context))
                     (not (eq (org-element-property :contents-begin context)
                              (org-element-property :contents-end context))))
                (unpackaged/org-element-descendant-of 'item context))  ; Element in list item, e.g. a link
            ;; Non-empty item: Add new item.
            (org-insert-item)
          ;; Empty item: Close the list.
          ;; TODO: Do this with org functions rather than operating on the text. Can't seem to find the right function.
          (delete-region (line-beginning-position) (line-end-position))
          (insert "\n"))))

     ((when (fboundp 'org-inlinetask-in-task-p)
        (org-inlinetask-in-task-p))
      ;; Inline task: Don't insert a new heading.
      (org-return t))

     ((org-at-table-p)
      (cond ((save-excursion
               (beginning-of-line)
               ;; See `org-table-next-field'.
               (cl-loop with end = (line-end-position)
                        for cell = (org-element-table-cell-parser)
                        always (equal (org-element-property :contents-begin cell)
                                      (org-element-property :contents-end cell))
                        while (re-search-forward "|" end t)))
             ;; Empty row: end the table.
             (delete-region (line-beginning-position) (line-end-position))
             (org-return t))
            (t
             ;; Non-empty row: call `org-return-indent'.
             (org-return t))))
     (t
      ;; All other cases: call `org-return-indent'.
      (org-return t)))))

(map!
 :after evil-org
 :map evil-org-mode-map
 :i [return] #'unpackaged/org-return-dwim)
;; Org Return:1 ends here

;; [[file:README.org::*Tables][Tables:1]]
(use-package! org-pretty-table
  :commands (org-pretty-table-mode global-org-pretty-table-mode))
;; Tables:1 ends here

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
(defvar org-babel-lang-list
  '("python" "ipython" "bash" "sh" "emacs-lisp"))
(dolist (lang org-babel-lang-list)
  (eval `(lsp-org-babel-enable ,lang)))
;; LSP Mode:1 ends here

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


(add-transient-hook! #'org-babel-execute-src-block
  (require 'ob-async))

(defvar org-babel-auto-async-languages '()
  "Babel languages which should be executed asyncronously by default.")

(defadvice! org-babel-get-src-block-info-eager-async-a (orig-fn &optional light datum)
  "Eagarly add an :async parameter to the src information, unless it seems problematic.
This only acts o languages in `org-babel-auto-async-languages'.
Not added when either:
+ session is not \"none\"
+ :sync is set"
  :around #'org-babel-get-src-block-info
  (let ((result (funcall orig-fn light datum)))
    (when (and (string= "none" (cdr (assoc :session (caddr result))))
               (member (car result) org-babel-auto-async-languages)
               (not (assoc :async (caddr result))) ; don't duplicate
               (not (assoc :sync (caddr result))))
      (push '(:async) (caddr result)))
    result))
;; Babel:1 ends here

;; [[file:README.org::*Bibtex][Bibtex:1]]
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
         "#+TITLE: ${title}\n"
         "#+ROAM_KEY: cite:${=key=}\n"
         "* TODO Notes\n"
         ":PROPERTIES:\n"
         ":CUSTOM_ID: ${=key=}\n"
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
;; Basic Config:1 ends here

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
                   ":END:\n")
           :unnarrowed t))))
;; Org Roam Bibtex:1 ends here

;; [[file:README.org::*Org-Pandoc][Org-Pandoc:1]]
(use-package! ox-pandoc
  :after org)
;; default options for all output formats
(setq org-pandoc-options          '((standalone . _))
      org-pandoc-options-for-docx '((standalone . nil)))
;; Org-Pandoc:1 ends here

;; [[file:README.org::*Org Import Pandoc][Org Import Pandoc:1]]
(use-package! org-pandoc-import
  :after org)
;; Org Import Pandoc:1 ends here

;; [[file:README.org::*Convert UPPERCASE KEYWORDS to lowercase keywords][Convert UPPERCASE KEYWORDS to lowercase keywords:1]]
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
;; Convert UPPERCASE KEYWORDS to lowercase keywords:1 ends here

;; [[file:README.org::*Org-Chef][Org-Chef:1]]
(use-package! org-chef
  :commands (org-chef-insert-recipe org-chef-get-recipe-from-url))
;; Org-Chef:1 ends here

;; [[file:README.org::*Mixed Pitch Mode][Mixed Pitch Mode:1]]
(autoload #'mixed-pitch-serif-mode "mixed-pitch"
  "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch." t)

(after! mixed-pitch
  (defface variable-pitch-serif
    '((t (:family "serif")))
    "A variable-pitch face with serifs."
    :group 'basic-faces)
  (setq mixed-pitch-set-height t)
  (setq variable-pitch-serif-font (font-spec :family "Alegreya" :size 21))
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
;; Mixed Pitch Mode:1 ends here

;; [[file:README.org::*Zen][Zen:1]]
(setq +zen-text-scale 0.25)
(defvar +zen-serif-p t
  "Whether to use a serifed font with `mixed-pitch-mode'.")
(after! writeroom-mode
  (defvar-local +zen--original-org-indent-mode-p nil)
  (defvar-local +zen--original-mixed-pitch-mode-p nil)
  (defvar-local +zen--original-org-pretty-table-mode-p nil)
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
                 +zen--original-org-indent-mode-p org-indent-mode
                 +zen--original-org-pretty-table-mode-p (bound-and-true-p org-pretty-table-mode))
                (org-indent-mode -1)
                (org-pretty-table-mode 1))))
  (add-hook 'writeroom-mode-disable-hook
            (defun +zen-nonprose-org-h ()
              "Reverse the effect of `+zen-prose-org'."
              (when (eq major-mode 'org-mode)
                (when +zen--original-org-indent-mode-p (org-indent-mode 1))
                ))))
;; Zen:1 ends here

;; [[file:README.org::*Dictionary][Dictionary:1]]
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
;; Dictionary:1 ends here

;; [[file:README.org::*PDF Tools][PDF Tools:1]]
(setq-default pdf-view-display-size 'fit-width)
(setq pdf-annot-activate-created-annotations t
      pdf-view-resize-factor 1.01)
;; PDF Tools:1 ends here

;; [[file:README.org::*Sync org files to dropbox][Sync org files to dropbox:1]]
(defun rsync-drop ()
  ;(setq shell-file-name "c:/msys64/usr/bin/bash.exe")
  (shell-command "rsync -avu --delete $HOME/git/org/ $HOME/Dropbox/org/"))

(add-hook! 'after-save-hook 'rsync-drop)
(add-hook! 'kill-emacs-hook 'rsync-drop)
;; Sync org files to dropbox:1 ends here
