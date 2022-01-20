;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name    "cupkax"
      user-mail-address "vedant.sansare@protonmail.com")

;Enable Dangerous Commands
(setq disabled-command-function nil)
(setq enable-local-eval t)

(setq inhibit-compacting-font-caches t
      undo-limit 80000000
      load-prefer-newer t
      evil-want-fine-undo t
      global-subword-mode 1
      delete-by-moving-to-trash t
      tab-width 4
      indent-tabs-mode nil
      uniquify-buffer-name-style 'forward
      window-combination-resize t
      x-stretch-cursor nil
      scroll-margin 3
      scroll-conservatively 1000
      scroll-up-aggressively 0.001
      scroll-down-aggressively 0.001
      scroll-preserve-screen-position 'always)
;(general-auto-unbind-keys)
(general-auto-unbind-keys :off)
(remove-hook 'doom-after-init-modules-hook #'general-auto-unbind-keys)
(whitespace-mode -1)
(global-auto-revert-mode 1)

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

(when (and (eq system-type 'gnu/linux)
           (string-match
            "Linux.*Microsoft.*Linux"
            (shell-command-to-string "uname -a")))
  (setq
   browse-url-generic-program  "/mnt/c/Windows/System32/cmd.exe"
   browse-url-generic-args     '("/c" "start")
   browse-url-browser-function #'browse-url-generic))

  (setq doom-font                (font-spec :family "JetBrainsMono Nerd Font"     :size 16)
        doom-variable-pitch-font (font-spec :family "Overpass Nerd Font"         :size 16)
        doom-unicode-font        (font-spec :family "Symbola"))
  (setq doom-font-increment 1)

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

(after! smartparens
  (show-smartparens-global-mode 1))

(setq evil-move-beyond-eol t
      evil-move-cursor-back nil
      evil-kill-on-visual-paste nil
      evil-visual-region-expanded t)

(defalias #'forward-evil-word #'forward-evil-symbol)

(setq evil-ex-substitute-global t)

(setq which-key-idle-delay 0.15)

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
  (consult-buffer))

(after! company
  (setq company-idle-delay 0
        company-minimum-prefix-length 2)
  (setq-default history-length 1000
                prescient-history-length 1000))

(set-file-template! "\\.org$" :trigger "__" :mode 'org-mode)

(setq deft-directory "~/org/roam/")

(setq org-directory "~/org/"
      org-startup-folded 'overview
      org-startup-with-inline-images t
      org-use-property-inheritance t
      org-list-allow-alphabetical t
      org-catch-invisible-edits 'smart
      org-startup-indented t
      org-adapt-indentation t
      org-indent-indentation-per-level 1
      org-cycle-separator-lines 1
      org-blank-before-new-entry '((heading . nil)
                                   (plain-list-item . nil))
      org-fontify-quote-and-verse-blocks t
      org-hide-emphasis-markers t
      org-id-link-to-org-use-id nil
      org-agenda-files (list "~/org/school.org"
                             "~/org/papers.org"
                             "~/org/home.org"
                             "~/org/Timesheet.org"
                             "~/org/calendar.org"
                             "~/org/roam/Meeting_Notes.org")
      org-log-done t
      org-time-stamp-custom-formats '("<%a %e-%b %Y>" . "<%a %e-%b %Y %H:%M>")
      org-checkbox-hierarchical-statistics nil
      ;org-element-use-cache nil
      )
(setq-default org-display-custom-times t)
;(add-hook 'org-mode-hook #'org-element-cache-reset 'append)

;; Update files with last modifed date, when #+lastmod: is available
  (setq time-stamp-active t
        time-stamp-line-limit 18
        time-stamp-start "#\\+lastmod:[ \t]*"
        time-stamp-end "$"
        time-stamp-format "\[%Y-%m-%d %a %H:%M:%S\]")
  (add-hook 'before-save-hook 'time-stamp nil)

(custom-set-faces!
  '(outline-1 :weight extra-bold :height 1.35)
  '(outline-2 :weight bold       :height 1.30)
  '(outline-3 :weight bold       :height 1.25)
  '(outline-4 :weight semi-bold  :height 1.20)
  '(outline-5 :weight semi-bold  :height 1.15)
  '(outline-6 :weight semi-bold  :height 1.10)
  '(outline-7 :weight semi-bold  :height 1.05)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold))

(custom-set-faces!
  '(org-document-title :height 1.20))

(use-package! org-appear
  :defer t
  :hook (org-mode . org-appear-mode)
  :init
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil))

(defun locally-defer-font-lock ()
  "Set jit-lock defer and stealth, when buffer is over a certain size."
  (when (> (buffer-size) 50000)
    (setq-local jit-lock-defer-time 0.05
                jit-lock-stealth-time 1)))

(add-hook 'org-mode-hook #'locally-defer-font-lock)

(setq org-ellipsis "  "
      org-pretty-entities t
      org-priority-highest ?A
      org-priority-lowest ?E
      org-priority-faces
      '((?A . 'all-the-icons-red)
        (?B . 'all-the-icons-orange)
        (?C . 'all-the-icons-yellow)
        (?D . 'all-the-icons-green)
        (?E . 'all-the-icons-blue)))

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
  )

(setq org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a.")))

;(use-package! valign
;  :defer t
;  :init (setq valign-fancy-bar t))

(use-package! org-pretty-table
  :commands (org-pretty-table-mode global-org-pretty-table-mode))

;; Org block templates
(setq org-structure-template-alist
      '(("e" . "src emacs-lisp")))


(after! org
  (setq org-return-follows-link t
        org-babel-load-languages '((emacs-lisp . t)
                             (dot . t))))

(defvar org-reference-contraction-max-words 3
  "Maximum number of words in a reference reference.")
(defvar org-reference-contraction-max-length 35
  "Maximum length of resulting reference reference, including joining characters.")
(defvar org-reference-contraction-stripped-words
  '("the" "on" "in" "off" "a" "for" "by" "of" "and" "is" "to")
  "Superfluous words to be removed from a reference.")
(defvar org-reference-contraction-joining-char "-"
  "Character used to join words in the reference reference.")

(defun org-reference-contraction-truncate-words (words)
  "Using `org-reference-contraction-max-length' as the total character 'budget' for the WORDS
and truncate individual words to conform to this budget.

To arrive at a budget that accounts for words undershooting their requisite average length,
the number of characters in the budget freed by short words is distributed among the words
exceeding the average length.  This adjusts the per-word budget to be the maximum feasable for
this particular situation, rather than the universal maximum average.

This budget-adjusted per-word maximum length is given by the mathematical expression below:

max length = \\floor{ \\frac{total length - chars for seperators - \\sum_{word \\leq average length} length(word) }{num(words) > average length} }"
  ;; trucate each word to a max word length determined by
  ;;
  (let* ((total-length-budget (- org-reference-contraction-max-length  ; how many non-separator chars we can use
                                 (1- (length words))))
         (word-length-budget (/ total-length-budget                      ; max length of each word to keep within budget
                                org-reference-contraction-max-words))
         (num-overlong (-count (lambda (word)                            ; how many words exceed that budget
                                 (> (length word) word-length-budget))
                               words))
         (total-short-length (-sum (mapcar (lambda (word)                ; total length of words under that budget
                                             (if (<= (length word) word-length-budget)
                                                 (length word) 0))
                                           words)))
         (max-length (/ (- total-length-budget total-short-length)       ; max(max-length) that we can have to fit within the budget
                        num-overlong)))
    (mapcar (lambda (word)
              (if (<= (length word) max-length)
                  word
                (substring word 0 max-length)))
            words)))

(defun org-reference-contraction (reference-string)
  "Give a contracted form of REFERENCE-STRING that is only contains alphanumeric characters.
Strips 'joining' words present in `org-reference-contraction-stripped-words',
and then limits the result to the first `org-reference-contraction-max-words' words.
If the total length is > `org-reference-contraction-max-length' then individual words are
truncated to fit within the limit using `org-reference-contraction-truncate-words'."
  (let ((reference-words
         (-filter (lambda (word)
                    (not (member word org-reference-contraction-stripped-words)))
                  (split-string
                   (->> reference-string
                        downcase
                        (replace-regexp-in-string "\\[\\[[^]]+\\]\\[\\([^]]+\\)\\]\\]" "\\1") ; get description from org-link
                        (replace-regexp-in-string "[-/ ]+" " ") ; replace seperator-type chars with space
                        puny-encode-string
                        (replace-regexp-in-string "^xn--\\(.*?\\) ?-?\\([a-z0-9]+\\)$" "\\2 \\1") ; rearrange punycode
                        (replace-regexp-in-string "[^A-Za-z0-9 ]" "") ; strip chars which need %-encoding in a uri
                        ) " +"))))
    (when (> (length reference-words)
             org-reference-contraction-max-words)
      (setq reference-words
            (cl-subseq reference-words 0 org-reference-contraction-max-words)))

    (when (> (apply #'+ (1- (length reference-words))
                    (mapcar #'length reference-words))
             org-reference-contraction-max-length)
      (setq reference-words (org-reference-contraction-truncate-words reference-words)))

    (string-join reference-words org-reference-contraction-joining-char)))

(define-minor-mode unpackaged/org-export-html-with-useful-ids-mode
  "Attempt to export Org as HTML with useful link IDs.
Instead of random IDs like \"#orga1b2c3\", use heading titles,
made unique when necessary."
  :global t
  (if unpackaged/org-export-html-with-useful-ids-mode
      (advice-add #'org-export-get-reference :override #'unpackaged/org-export-get-reference)
    (advice-remove #'org-export-get-reference #'unpackaged/org-export-get-reference)))
(unpackaged/org-export-html-with-useful-ids-mode 1) ; ensure enabled, and advice run

(defun unpackaged/org-export-get-reference (datum info)
  "Like `org-export-get-reference', except uses heading titles instead of random numbers."
  (let ((cache (plist-get info :internal-references)))
    (or (car (rassq datum cache))
        (let* ((crossrefs (plist-get info :crossrefs))
               (cells (org-export-search-cells datum))
               ;; Preserve any pre-existing association between
               ;; a search cell and a reference, i.e., when some
               ;; previously published document referenced a location
               ;; within current file (see
               ;; `org-publish-resolve-external-link').
               ;;
               ;; However, there is no guarantee that search cells are
               ;; unique, e.g., there might be duplicate custom ID or
               ;; two headings with the same title in the file.
               ;;
               ;; As a consequence, before re-using any reference to
               ;; an element or object, we check that it doesn't refer
               ;; to a previous element or object.
               (new (or (cl-some
                         (lambda (cell)
                           (let ((stored (cdr (assoc cell crossrefs))))
                             (when stored
                               (let ((old (org-export-format-reference stored)))
                                 (and (not (assoc old cache)) stored)))))
                         cells)
                        (when (org-element-property :raw-value datum)
                          ;; Heading with a title
                          (unpackaged/org-export-new-named-reference datum cache))
                        (when (member (car datum) '(src-block table example fixed-width property-drawer))
                          ;; Nameable elements
                          (unpackaged/org-export-new-named-reference datum cache))
                        ;; NOTE: This probably breaks some Org Export
                        ;; feature, but if it does what I need, fine.
                        (org-export-format-reference
                         (org-export-new-reference cache))))
               (reference-string new))
          ;; Cache contains both data already associated to
          ;; a reference and in-use internal references, so as to make
          ;; unique references.
          (dolist (cell cells) (push (cons cell new) cache))
          ;; Retain a direct association between reference string and
          ;; DATUM since (1) not every object or element can be given
          ;; a search cell (2) it permits quick lookup.
          (push (cons reference-string datum) cache)
          (plist-put info :internal-references cache)
          reference-string))))

(defun unpackaged/org-export-new-named-reference (datum cache)
  "Return new reference for DATUM that is unique in CACHE."
  (cl-macrolet ((inc-suffixf (place)
                             `(progn
                                (string-match (rx bos
                                                  (minimal-match (group (1+ anything)))
                                                  (optional "--" (group (1+ digit)))
                                                  eos)
                                              ,place)
                                ;; HACK: `s1' instead of a gensym.
                                (-let* (((s1 suffix) (list (match-string 1 ,place)
                                                           (match-string 2 ,place)))
                                        (suffix (if suffix
                                                    (string-to-number suffix)
                                                  0)))
                                  (setf ,place (format "%s--%s" s1 (cl-incf suffix)))))))
    (let* ((headline-p (eq (car datum) 'headline))
           (title (if headline-p
                      (org-element-property :raw-value datum)
                    (or (org-element-property :name datum)
                        (concat (org-element-property :raw-value
                                                      (org-element-property :parent
                                                                            (org-element-property :parent datum)))))))
           ;; get ascii-only form of title without needing percent-encoding
           (ref (concat (org-reference-contraction (substring-no-properties title))
                        (unless (or headline-p (org-element-property :name datum))
                          (concat ","
                                  (pcase (car datum)
                                    ('src-block "code")
                                    ('example "example")
                                    ('fixed-width "mono")
                                    ('property-drawer "properties")
                                    (_ (symbol-name (car datum))))
                                  "--1"))))
           (parent (when headline-p (org-element-property :parent datum))))
      (while (--any (equal ref (car it))
                    cache)
        ;; Title not unique: make it so.
        (if parent
            ;; Append ancestor title.
            (setf title (concat (org-element-property :raw-value parent)
                                "--" title)
                  ;; get ascii-only form of title without needing percent-encoding
                  ref (org-reference-contraction (substring-no-properties title))
                  parent (when headline-p (org-element-property :parent parent)))
          ;; No more ancestors: add and increment a number.
          (inc-suffixf ref)))
      ref)))

(add-hook 'org-load-hook #'unpackaged/org-export-html-with-useful-ids-mode)
(defadvice! org-export-format-reference-a (reference)
  "Format REFERENCE into a string.

REFERENCE is a either a number or a string representing a reference,
as returned by `org-export-new-reference'."
  :override #'org-export-format-reference
  (if (stringp reference) reference (format "org%07x" reference)))

(defadvice! shut-up-org-problematic-hooks (orig-fn &rest args)
  :around #'org-fancy-priorities-mode
  :around #'org-superstar-mode
  (ignore-errors (apply orig-fn args)))

  (setq bibtex-completion-bibliography "~/Dropbox/research/zotLib.bib"
        citar-bibliography '("~/Dropbox/research/zotLib.bib")
        bibtex-completion-additional-search-fields '(journal booktitle keywords)
        bibtex-completion-pdf-field "file"
        bibtex-completion-library-path '("~/Dropbox/research/zotero-library/")
        citar-library-paths '("~/Dropbox/research/zotero-library/")
        bibtex-completion-notes-path "~/org/roam/"
        citar-notes-paths '("~/org/roam/")
        bibtex-completion-display-formats '((t . "${author:36} ${title:*} ${year:4} ${=has-pdf=:1}${=has-note=:1} ${=type=:7}")))

(require 'time-stamp)  ;; for automatically add time stamp in org files
(add-hook 'write-file-functions 'time-stamp)

;; Modification Times
(setq org-roam-node-display-template
      (concat "${title:80} " (propertize "${tags:20}" 'face 'org-tag))
      org-roam-node-annotation-function
      (lambda (node) (marginalia--time (org-roam-node-file-mtime node))))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :commands org-roam-ui-open
  :hook (org-roam . org-roam-ui-mode)
  :config
  (require 'org-roam) ; in case autoloaded
  (defun org-roam-ui-open ()
    "Ensure the server is active, then open the roam graph."
    (interactive)
    (unless org-roam-ui-mode (org-roam-ui-mode 1))
    (browse-url-xdg-open (format "http://localhost:%d" org-roam-ui-port))))

(use-package! org-roam
  :init
  (setq org-roam-db-gc-threshold most-positive-fixnum
        org-id-link-to-org-use-id t
        org-roam-completion-everywhere nil)
  :config
  (org-roam-setup)
  (add-hook 'org-roam-mode-hook #'turn-on-visual-line-mode)

  (setq org-roam-capture-templates
        '(
          ("i" "inbox" plain
           "%?"
           :if-new (file+head "%<%y%m%d>-${slug}.org"
                              "#+title: ${title}")
           :immediate-finish t
           :unnarrowed t)
          ;; org-roam-bibtex
          ("r" "bibliography ref" plain
           "%?"
           :if-new (file+head "${citekey}.org"
                              "#+title: ${title}
#+ROAM_KEY: ${ref}
:PROPERTIES:
:Custom_ID: ${citekey}
:AUTHOR: ${author-abbrev}
:DATE: ${date}
:YEAR: ${year}
:DOI: ${doi}
:URL: ${url}
:END:

- tags ::
** Why
why I read this paper?
- background and related work?
** Synopsis
*** The Idea
*** Short Summary
* Reading Notes
:PROPERTIES:
:NOTER_DOCUMENT: ${file}
:NOTER_PAGE:
:END:")
           :unnarrowed t)))
  (set-company-backend! 'org-mode '(company-capf))
  (require 'org-roam-protocol))

(use-package! org-transclusion
  :defer
  :after org
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))

(setq org-highlight-latex-and-related '(native script entities))
(require 'org-src)
(add-to-list 'org-src-block-faces '("latex" (:inherit default :extend t)))

(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode))

; Fragments same size as text
(setq org-format-latex-header "\\documentclass{article}
\\usepackage[usenames]{xcolor}

\\usepackage[T1]{fontenc}

\\usepackage{booktabs}

\\pagestyle{empty}             % do not remove
% The settings below are copied from fullpage.sty
\\setlength{\\textwidth}{\\paperwidth}
\\addtolength{\\textwidth}{-3cm}
\\setlength{\\oddsidemargin}{1.5cm}
\\addtolength{\\oddsidemargin}{-2.54cm}
\\setlength{\\evensidemargin}{\\oddsidemargin}
\\setlength{\\textheight}{\\paperheight}
\\addtolength{\\textheight}{-\\headheight}
\\addtolength{\\textheight}{-\\headsep}
\\addtolength{\\textheight}{-\\footskip}
\\addtolength{\\textheight}{-3cm}
\\setlength{\\topmargin}{1.5cm}
\\addtolength{\\topmargin}{-2.54cm}
% my custom stuff
\\usepackage[nofont,plaindd]{bmc-maths}
\\usepackage{arev}
")

; Fragments transparent backrground face
(setq org-format-latex-options
      (plist-put org-format-latex-options :background "Transparent"))

(use-package! ox-extra
  :after org
  :config
  (ox-extras-activate '(latex-header-blocks ignore-headlines)))

(use-package! ox-latex
  :after org
  :config
  (setq org-latex-pdf-process
        '("pdflatex -interaction nonstopmode -output-directory %o %f"
          "bibtex %b"
          "pdflatex -interaction nonstopmode -output-directory %o %f"
          "pdflatex -interaction nonstopmode -output-directory %o %f"))
  (setq org-latex-hyperref-template nil) ;; stop org adding hypersetup{author..} to latex export
  ;; (setq org-latex-prefer-user-labels t)

  ;; deleted unwanted file extensions after latexMK
  (setq org-latex-logfiles-extensions
        (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "xmpi" "run.xml" "bcf" "acn" "acr" "alg" "glg" "gls" "ist")))

  (unless (boundp 'org-latex-classes)
    (setq org-latex-classes nil)))

(use-package! org-pandoc-import
  :after org)

(defvar mixed-pitch-modes '(org-mode LaTeX-mode markdown-mode gfm-mode Info-mode)
  "Modes that `mixed-pitch-mode' should be enabled in, but only after UI initialisation.")
(defun init-mixed-pitch-h ()
  "Hook `mixed-pitch-mode' into each mode in `mixed-pitch-modes'.
Also immediately enables `mixed-pitch-modes' if currently in one of the modes."
  (when (memq major-mode mixed-pitch-modes)
    (mixed-pitch-mode 1))
  (dolist (hook mixed-pitch-modes)
    (add-hook (intern (concat (symbol-name hook) "-hook")) #'mixed-pitch-mode)))
(add-hook 'doom-init-ui-hook #'init-mixed-pitch-h)

(autoload #'mixed-pitch-serif-mode "mixed-pitch"
  "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch." t)

(after! mixed-pitch
  (defface variable-pitch-serif
    '((t (:family "serif")))
    "A variable-pitch face with serifs."
    :group 'basic-faces)
  (setq mixed-pitch-set-height t)
  (setq variable-pitch-serif-font (font-spec :family "Alegreya" :size 16 ))
  (set-face-attribute 'variable-pitch-serif nil :font variable-pitch-serif-font)
  (defun mixed-pitch-serif-mode (&optional arg)
    "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch."
    (interactive)
    (let ((mixed-pitch-face 'variable-pitch-serif))
      (mixed-pitch-mode (or arg 'toggle)))))

(setq writeroom-mode-line t
      +zen-text-scale 1.50
      +zen-window-divider-size 2)

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
            'display-line-numbers
            'visual-fill-column-width
            'org-adapt-indentation)
            ;'org-superstar-headline-bullets-list
            ;'org-superstar-remove-leading-stars)
  (add-hook 'writeroom-mode-enable-hook
            (defun +zen-prose-org-h ()
              "Reformat the current Org buffer appearance for prose."
              (when (eq major-mode 'org-mode)
                (setq display-line-numbers nil
                      visual-fill-column-width 60
                      org-adapt-indentation nil)
                ;(when (featurep 'org-superstar)
                ;  (setq-local org-superstar-headline-bullets-list '("??" "??" "??" "??")
                ;              ;; org-superstar-headline-bullets-list '("??" "??" "??" "??" "??" "??" "??" "??")
                ;              org-superstar-remove-leading-stars t)
                ;  (org-superstar-restart))
                (setq
                 +zen--original-org-indent-mode-p org-indent-mode
                 +zen--original-org-pretty-table-mode-p (bound-and-true-p org-pretty-table-mode))
                (org-indent-mode -1)
                (org-pretty-table-mode 1))))
  (add-hook 'writeroom-mode-disable-hook
            (defun +zen-nonprose-org-h ()
              "Reverse the effect of `+zen-prose-org'."
              (when (eq major-mode 'org-mode)
                ;(when (featurep 'org-superstar)
                ;  (org-superstar-restart))
                (when +zen--original-org-indent-mode-p (org-indent-mode 1))
                ;; (unless +zen--original-org-pretty-table-mode-p (org-pretty-table-mode -1))
                ))))

(setq ispell-dictionary "en-custom"
      ispell-personal-dictionary (expand-file-name ".ispell_personal" doom-private-dir)
      ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra")
      ispell-local-dictionary-alist
      '(("en_custom" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil nil nil utf-8)))

                                        ;(add-hook 'text-mode-hook 'flyspell-mode)
                                        ;(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(defun rsync-drop ()
  (interactive)
  ;(setq shell-file-name "c:/msys64/usr/bin/bash.exe")
  (shell-command "rsync -avu --delete $HOME/org/ $HOME/Dropbox/org/"))

;(add-hook! 'after-save-hook 'rsync-drop)
;(add-hook! 'kill-emacs-hook 'rsync-drop)
