let s:project_root = expand('<sfile>:p:h')
let s:path_ts = s:project_root . '/orchestration'

let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

let g:ale_linters = {}
let g:ale_linters.typescript = ['eslint']

let g:ale_fixers = {'terraform-vars': ['terraform']}
let g:ale_fixers.javascript = ['prettier']
let g:ale_fixers.markdown = ['prettier']
let g:ale_fixers.terraform = ['terraform']
let g:ale_fixers.typescript = ['eslint', 'prettier']

let g:test#javascript#jest#options = ''

function! s:CoverageClear()
  let g:coverage_enabled = 0
  :CoverageClear
endfunction

function! s:ToggleCoverage()
  if &filetype ==# 'typescript'
    execute 'cd' s:path_ts
  endif
  if exists('g:coverage_enabled') && g:coverage_enabled == 1
    call s:CoverageClear()
  else
    let g:coverage_enabled = 1
    :Coverage
  endif
  if &filetype ==# 'typescript'
    execute 'cd' s:project_root
  endif
endfunction

function! s:TestRun(cmd, doCover) abort
  if &filetype =~# 'typescript'
    let g:test#project_root = s:path_ts
    if a:doCover == 1
      let l:options = g:test#javascript#jest#options
      let g:test#javascript#jest#options = g:test#javascript#jest#options . ' --no-cache --coverage'
    endif
  endif

  if a:doCover == 1
    call s:CoverageClear()
  endif

  execute 'Test' . a:cmd

  if &filetype =~# 'typescript'
    unlet g:test#project_root
    execute 'cd' s:project_root
    if a:doCover == 1
      let g:test#javascript#jest#options = l:options
    endif
  endif
endfunction

nnoremap <silent><leader>xt :call <SID>TestRun("Nearest", 0)<CR>
nnoremap <silent><leader>xtc :call <SID>TestRun("Nearest", 1)<CR>
nnoremap <silent><leader>xtcc :call <SID>TestRun("File", 1)<CR>
nnoremap <silent><leader>xtf :call <SID>TestRun("File", 0)<CR>
nnoremap <silent><leader>xtl :call <SID>TestRun("Last", 0)<CR>
" nnoremap <silent><leader>cc :call <SID>ToggleCoverage()<CR>
" nnoremap <silent><leader>cs :CoverageSummary<CR>
