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
