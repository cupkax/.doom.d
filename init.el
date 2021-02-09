;;; init.el -*- lexical-binding: t; -*-
(doom!
 :completion
 (company
  +childframe)
 (ivy
  +prescient
  +icons
  +fuzzy)

 :ui
 deft
 doom
 doom-dashboard
 hl-todo
 hydra
 (ligatures
  +extra)
 (modeline)
 ophints
 (popup
  +all
  +defaults)
 (window-select
  +numbers)
 workspaces
 zen

 :editor
 (evil
  +everywhere)
 fold
 (format
  +onsave)
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
  +hugo
  +noter
  +pandoc
  +pretty
  +roam)
 (python
  +lsp)
 (sh
  +powershell)

 :email
 

 :app
 

 :config
 (default
   +bindings
   +smartparens)
 )
