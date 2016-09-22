" LilyPond indent file
" Language:     LilyPond
" Maintainer:   Heikki Junes <hjunes@cc.hut.fi>
" Last Change:  2010 Jul 26
"
" Installed As:	vim/indent/lilypond.vim
"
" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetLilyPondIndent()
setlocal indentkeys=o,O,},>>,!^F

" Only define the function once.
if exists("*GetLilyPondIndent")
  finish
endif

function GetLilyPondIndent()
  if v:lnum == 1
    return 0
  endif

  "Find a non-blank line above the current line.
  let lnum = prevnonblank(v:lnum - 1)
  let prevline = getline(lnum)
  "Check if a block was started: '{' or '<<' is the last non-blank character of the previous line.
  if prevline =~ '^[^%]*\({\|<<\)\s*$' || prevline =~ '^\s*%\s*\({{{\).*$'
    let ind = indent(lnum) + &sw
  else
    let ind = indent(lnum)
  endif

  "Check if a block was ended: '}' or '>>' is the first non-blank character of the current line.
  if prevline =~ '^\s*\(}\|>>\)'|| prevline =~ '^\s*%\s*\(}}}\)$'
    let ind = ind - &sw
  endif

  return ind
endfunction
"
"
"
