
" ============================================================================
" File:        statline.vim
" Maintainer:  Miller Medeiros <http://blog.millermedeiros.com/>
" Description: Add useful info to the statusline and basic error checking.
" Last Change: October 05, 2011
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
" Modified:   mkitt tweaked some settings for our preferences
" ============================================================================

" ====== colors ======

" using link instead of named highlight group inside the statusline to make it
" easier to customize, reseting the User[n] highlight will remove the link.
" Another benefit is that colors will adapt to colorscheme.

"filename
hi default link User1 Identifier
" flags
hi default link User2 Statement
" errors
hi default link User3 Error
" fugitive
hi default link User4 Special



" ====== basic info ======


" buffer number (always shown)
set statusline=[%n]\ %<
" filename (tail)
set statusline+=%1*[%f]%*
" flags (h:help:[help], w:window:[Preview], m:modified:[+][-], r:readonly:[RO])
set statusline+=%2*%h%w%m%r%*
" filetype
set statusline+=\ %y
" file format → file encoding
" set statusline+=[%{&ff}→%{strlen(&fenc)?&fenc:'No\ Encoding'}]

" separation between left/right aligned items
set statusline+=%=

" current line and column (-:left align, 14:minwid, l:line, L:nLines, c:column)
set statusline+=%-14(\ L%l/%L:C%c\ %)
" scroll percent
set statusline+=%P


" Fugitive
if !exists('g:statline_fugitive')
    let g:statline_fugitive = 0
endif
if g:statline_fugitive
    set statusline+=%4*%{fugitive#statusline()}%*
endif

" RVM
if !exists('g:statline_rvm')
    let g:statline_rvm = 0
endif
if g:statline_rvm
    set statusline+=%{rvm#statusline()}
endif


" Syntastic errors
if !exists('g:statline_syntastic')
    let g:statline_syntastic = 1
endif
if g:statline_syntastic
    set statusline+=\ %3*%{SyntasticStatuslineFlag()}%*
endif




" ====== custom errors ======


" these methods were based on factorylabs/vimfiles


" ---- mixed indenting ----

if !exists('g:statline_mixed_indent')
    let g:statline_mixed_indent = 1
endif

function! StatlineTabWarning()
    if !exists("b:statline_indent_warning")
        let tabs = search('^\t', 'nw') != 0
        " ignore spaces just before JavaDoc style comments
        let spaces = search('^ \(?<!*\)', 'nw') != 0
        let mixed = search('^\( \+\t\|\t\+ \+\(?<!*\)\)', 'nw') != 0

        if mixed
            let b:statline_indent_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statline_indent_warning = '[&et]'
        else
            let b:statline_indent_warning = ''
        endif
    endif
    return b:statline_indent_warning
endfunction

if g:statline_mixed_indent
    set statusline+=%3*%{StatlineTabWarning()}%*
    " recalculate when idle and after writing
    autocmd cursorhold,bufwritepost * unlet! b:statline_indent_warning
endif


" --- trailing white space ---

if !exists('g:statline_trailing_space')
    let g:statline_trailing_space = 1
endif

function! StatlineTrailingSpaceWarning()
    if !exists("b:statline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statline_trailing_space_warning = '[\s]'
        else
            let b:statline_trailing_space_warning = ''
        endif
    endif
    return b:statline_trailing_space_warning
endfunction

if g:statline_trailing_space
    set statusline+=%3*%{StatlineTrailingSpaceWarning()}%*
    " recalculate when idle, and after saving
    autocmd cursorhold,bufwritepost * unlet! b:statline_trailing_space_warning
endif

