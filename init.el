;;; init.el -*- lexical-binding: t; -*-
(doom!
 :completion
 (company
  +childframe
  +tng)
 (ivy
  +prescient
  +icons
  +fuzzy)

 :ui
 deft
 doom
 doom-dashboard
                                         ;doom-quit
 hl-todo
 hydra
 (ligatures
  +extra
  +fira)
 modeline
 ;nav-flash
 ophints
 (popup
  +all
  +defaults)
 treemacs
 vi-tilde-fringe
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
 syntax

 :tools
 (eval
  +overlay)
 lsp
 magit
 make
 pdf
 rgb

 :os
 

 :lang
 data
 emacs-lisp
 ledger
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
