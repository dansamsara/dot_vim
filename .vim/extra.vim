" ------
" VSCode
" ------
if exists('g:vscode')
  " The normal bindings for these break in VSCode.
  nnoremap <silent> <leader>hs :split
  nnoremap <silent> <leader>vs :vsplit
  nnoremap <silent> <leader>tn :echom 'not supported'<CR>
endif

" ------------
" terraform-ls
" ------------
" Work around for unexpected attribute in tfvars
" See https://github.com/hashicorp/terraform-ls/issues/1838#issuecomment-2519482970
autocmd BufRead,BufNewFile *.tfvars set filetype=terraform-vars syntax=terraform

" ----
" Git
" ----
nnoremap <leader>gF :belowright split \| terminal git f<CR>

" ----------
" coc.nvim
" ----------

" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#install-extensions
" Automatically install coc.nvim extensions if not installed.
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-go',
      \ 'coc-json',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ ]

" ----------------------
" OS specific settings
" ----------------------

if has('linux')
  if !has('nvim')
    " Ubuntu 20.04 still runs Vim 8.1
    let g:coc_disable_startup_warning = 1
  endif
endif


" Python 3 virtual environment for Neovim where pynvim is installed.
let g:python3_host_prog = '~/.config/nvim/venv/bin/python3'

" ----------------
" copilot.vim
" ----------------
let g:copilot_node_command = [$COC_NODE_PATH]

" -------------
" ale.vim
" -------------

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#checking_symbol = 'ale...'

" ----------------
" autoformat.vim
" ----------------

" https://github.com/vim-autoformat/vim-autoformat?tab=readme-ov-file#basic-definitions
let g:formatdef_d2 = '"d2 fmt -"'
let g:formatters_d2 = ['d2']
let g:autoformat_verbosemode = 0

" ---------------------
" markdown-preview.nvim
" ---------------------
if has('linux')
  let g:mkdp_port = 3000
endif

" ----------------------------------
" Escape text for pasting into Vim
" ----------------------------------

function! EscapeText(text)
  let l:escaped_text = a:text

  " Map characters to named C backslash escapes. Normally, single-quoted
  " strings don't require double-backslashing, but these are necessary
  " to make the substitute() call below work properly.
  "
  let l:charmap = {
  \   '"'     : '\\"',
  \   "'"     : '\\''',
  \   "\n"    : '\\n',
  \   "\r"    : '\\r',
  \   "\b"    : '\\b',
  \   "\t"    : '\\t',
  \   "\x07"  : '\\a',
  \   "\x0B"  : '\\v',
  \   "\f"    : '\\f',
  \   }

  " Escape any existing backslashes in the text first, before
  " generating new ones. (Vim dictionaries iterate in arbitrary order,
  " so this step can't be combined with the items() loop below.)
  "
  let l:escaped_text = substitute(l:escaped_text, "\\", '\\\', 'g')

  " Replace actual returns, newlines, tabs, etc., with their escaped
  " representations.
  "
  for [original, escaped] in items(charmap)
      let l:escaped_text = substitute(l:escaped_text, original, escaped, 'g')
  endfor

  " Replace any other character that isn't a letter, number,
  " punctuation, or space with a 3-digit octal escape sequence. (Octal
  " is used instead of hex, since octal escapes terminate after 3
  " digits. C allows hex escapes of any length, so it's possible for
  " them to run up against subsequent characters that might be valid
  " hex digits.)
  "
  let l:escaped_text = substitute(l:escaped_text,
  \   '\([^[:alnum:][:punct:] ]\)',
  \   '\="\\o" . printf("%03o",char2nr(submatch(1)))',
  \   'g')

  return l:escaped_text
endfunction

function! PasteEscapedRegister(where)
  " Remember current register name, contents, and type,
  " so they can be restored once we're done.
  "
  let l:save_reg_name     = v:register
  let l:save_reg_contents = getreg(l:save_reg_name, 1)
  let l:save_reg_type     = getregtype(l:save_reg_name)

  echo "register: [" . l:save_reg_name . "] type: [" . l:save_reg_type . "]"

  " Replace the contents of the register with the escaped text, and set the
  " type to characterwise (so pasting into an existing double-quoted string,
  " for example, will work as expected).
  "
  call setreg(l:save_reg_name, EscapeText(getreg(l:save_reg_name)), "c")

  " Build the appropriate normal-mode paste command.
  "
  let l:cmd = 'normal "' . l:save_reg_name . (a:where == "before" ? "P" : "p")

  " Insert the escaped register contents.
  "
  exec l:cmd

  " Restore the register to its original value and type.
  "
  call setreg(l:save_reg_name, l:save_reg_contents, l:save_reg_type)
endfunction

" Define keymaps to paste escaped text before or after the cursor.
"
nmap <silent><leader>P :call PasteEscapedRegister("before")<cr>
nmap <silent><leader>p :call PasteEscapedRegister("after")<cr>

" ----------------------------------------------
" Search escaped text in the current register.
" ----------------------------------------------

function! SearchEscapedRegister()
  let @/ = EscapeText(getreg(v:register, 1))
  :norm n
endfunction

" Define keymaps to search escaped text before or after the cursor.
nnoremap <silent><leader>se :call SearchEscapedRegister()<cr>
