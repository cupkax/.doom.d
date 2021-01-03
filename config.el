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
