;;; init.el -*- lexical-binding: t; -*-
(doom!
 :completion
 (company
  +childframe)
 (ivy
  +prescient
  +icons)

 :ui
 doom
 doom-dashboard
 ;(emoji
 ; +unicode)
 hl-todo
 hydra
 (ligatures
  +extra)
 modeline
 ophints
 (popup
  +all
  +defaults)
 unicode
 (window-select
  +numbers)
 workspaces
 zen

 :editor
 (evil
  +everywhere)
 file-templates
 fold
 (format
  +onsave)
 parinfer
 multiple-cursors
 rotate-text
 snippets
                                         ;word-wrap  ; Disabled for performance

 :emacs
 (dired
  +icons)
 electric
 undo
 vc

 :term
 

 :checkers
 (syntax
  +childframe)
 (:if (executable-find "aspell") spell)
 grammar

 :tools
 (eval
  +overlay)
 (lookup
  +docsets
  +dictionary
  +offline)
 (lsp
  +peek)
 (magit
  +forge)
 pdf
 rgb

 :os
 

 :lang
 data
 emacs-lisp
 markdown
 (org
  +dragndrop
  +gnuplot
  +noter
  +pandoc
  +pretty
  +roam)
 (python
  +lsp
  +pyright
  +poetry)
 (sh
  +powershell)
 yaml

 :email
 

 :app
 

 :config
 (default
   +bindings
   +smartparens)
 )
