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
 doom-quit
 hl-todo
 hydra
 ligatures
 modeline
 nav-flash
 ophints
 (popup
  +all
  +defaults)
 treemacs
                                         ;unicode
 vc-gutter
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
 word-wrap

 :emacs
 (dired
  +ranger
  +icons)
 electric
 ;(ibuffer +icons)
 (undo +tree)
 vc

 :term
 vterm

 :checkers
 syntax
 ;spell
 ;grammar

 :tools
 (eval
  +overlay)
 gist
 (lookup
  +offline
  +dictionary
  +docsets)
 lsp
 magit
 make
 pdf
 rgb

 :os
 

 :lang
 (csharp
  +lsp
  +unity)
 data
 emacs-lisp
 (json
  +lsp)
 (javascript
  +lsp)
 ledger
 lua
 markdown
 (org
  +dragndrop
  +gnuplot
  +hugo
  +journal
  +noter
  +pandoc
  +pretty
  +roam)
 (python
  +poetry
  +lsp)
 (sh
  +powershell)
 web
 (yaml
  +lsp)

 :email
 

 :app
 ;;calendar
 ;;irc               ; how neckbeards socialize
 ;;(rss +org)        ; emacs as an RSS reader
 ;;twitter           ; twitter client https://twitter.com/vnought
 ;;write             ; emacs for writers (fiction, notes, papers, etc.)

 :config
 ;literate
 (default
   +bindings
   +smartparens)
 )
