;;; init.el -*- lexical-binding: t; -*-
(doom!
 :completion
 (company
  +tng)
 (ivy
  +prescient
  +icons)

 :ui
 ;deft
 ;doom
 doom-dashboard
 hl-todo
 ;hydra
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
 zen

 :editor
 (evil
  +everywhere)
 fold
 format
 multiple-cursors
 rotate-text
 snippets
 word-wrap

 :emacs
 (dired
  +icons)
 electric
 (ibuffer
  +icons)
 undo
 vc

 :term
 

 :checkers
 (syntax
  +childframe)
 (spell
  +enchant
  +flyspell)
 ;grammar

 :tools
 ;debugger
 (eval
  +overlay)
 (lookup
  +docsets
  +dictionary
  +offline)
 (lsp
  +peek)
 magit
 pdf
 rgb

 :os
 

 :lang
 data
 emacs-lisp
 (markdown
  +grip)
 (org
  +dragndrop
  +pandoc
  +pretty
  +roam)
 (python
  +lsp
  +pyright)
 (sh
  +powershell)

 :email
 

 :app
 

 :config
 (default
   +bindings
   +smartparens))
(load! "+init")
