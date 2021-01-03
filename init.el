;;; init.el -*- lexical-binding: t; -*-
(doom!
 :completion
 (company
  +childframe)
 (ivy
  +childframe
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
 unicode
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
 multiple-cursors
 rotate-text
 snippets
 word-wrap

 :emacs
 (dired
  +ranger
  +icons)
 electric
 (ibuffer +icons)
 (undo +tree)
 vc

 :term
 vterm

 :checkers
 (syntax
  +childframe)
 spell
 grammar

 :tools
 direnv
 editorconfig
 (eval
  +overlay)
 gist
 (lookup
  +offline
  +dictionary
  +docsets)
 lsp
 (magit)
 make
 pdf
 rgb

 :os
 tty

 :lang
 (csharp
  +lsp)
 data
 emacs-lisp
 json
 (javascript
  +lsp)
 ledger
 lua
 markdown
 (org
  +dragndrop
  +gnuplot
  +hugo
  +pandoc
  +pretty
  +roam)
 (python
  +poetry
  +lsp)
 scheme
 sh
 web
 yaml

 :email
 (mu4e
  +org
  +gmail)

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
