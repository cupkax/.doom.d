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
 modeline
                                         ;nav-flash
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
 file-templates
 fold
 (format
  +onsave)
 rotate-text
 snippets
 ;;word-wrap

 :emacs
 (dired
  +icons
  +ranger)
 electric
 (ibuffer +icons)
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
  +dictionary)
 (lsp
  +peek)
 (magit
  +forge)
 make
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
