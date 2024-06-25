" Directory where this script lives.
let s:project_root = expand('<sfile>:p:h')
" Directory for Samsara go source.
let s:path_go = s:project_root . '/go/src/samsaradev.io'
let s:go_coverage_file = s:path_go . '/coverage.out'
" Base golangci-lint config.
let s:golangci_lint_options = '--config=' . s:path_go . '/.golangci-localdev.yml '
      \ . '--timeout 15m '

augroup ExtraAutoCommands
  autocmd!

  autocmd BufRead,BufNewFile CODEREVIEW set filetype=json
  autocmd SessionLoadPost * silent! VimspectorLoadSession
augroup end

if has('linux')
  " Ensure a couple cores are free
  let g:ale_go_golangci_lint_options = s:golangci_lint_options . '--concurrency 14'
  let g:ale_go_golangci_lint_executable = 'gcl-samsara-lint'
else
  let g:ale_go_golangci_lint_options = s:golangci_lint_options

  augroup OsExtraAutoCommands
    autocmd!

    autocmd BufNewFile,BufRead *.go call RemoteAleCommands()
    function! RemoteAleCommands()
      let l:path_arg = '@' . expand("%:p:h")
      let g:ale_go_golangci_lint_executable = 'remote-golangci-lint'
      let b:ale_go_golangci_lint_options = s:golangci_lint_options . ' ' . l:path_arg
      let g:ale_go_staticcheck_executable = 'remote-staticcheck'
      let b:ale_go_staticcheck_options = '-tests=false ' . l:path_arg
    endfunction
  augroup end
endif

let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

let g:ale_proto_protoc_gen_lint_options =  '-I ' . s:project_root . '/go/src -I ' . s:path_go . '/vendor'
let g:ale_go_golangci_lint_package = 1
let g:ale_go_staticcheck_lint_package = 1
let g:ale_go_staticcheck_options = '-tests=false'
let g:ale_javascript_eslint_options = '--cache -c .eslintrc-incremental.js'
let g:ale_yaml_yamllint_options = '-c .yamllintconfig'

let g:ale_linters = {}
let g:ale_linters.go = ['goimports', 'staticcheck', "golangci-lint"]
let g:ale_linters.dockerfile = ['hadolint']
let g:ale_linters.graphql = []
let g:ale_linters.javascript = ['eslint']
let g:ale_linters.sh = ['shellcheck']
let g:ale_linters.typescript = ['eslint', 'tslint']
let g:ale_linters.typescriptreact = ['eslint', 'tslint']

let g:ale_fixers = {}
let g:ale_fixers.css = ['prettier']
let g:ale_fixers.go = ['goimports']
let g:ale_fixers.graphql = ['prettier']
let g:ale_fixers.javascript = ['eslint', 'prettier']
let g:ale_fixers.javascriptreact = ['prettier']
let g:ale_fixers.less = ['prettier']
let g:ale_fixers.markdown = ['prettier']
let g:ale_fixers.scss = ['prettier']
let g:ale_fixers.sh = ['shfmt']
let g:ale_fixers.terraform = ['terraform']
let g:ale_fixers.typescript = ['eslint', 'prettier']
let g:ale_fixers.typescriptreact = ['eslint', 'prettier']
let g:ale_fixers.yaml = ['prettier']

" Disable until it can be restricted to go and ts src files.
let g:gutentags_enabled = 0
let g:gutentags_ctags_exclude = [
      \ 'bin',
      \ 'build',
      \ 'compiled',
      \ 'coverage',
      \ 'dist',
      \ 'logs',
      \ 'node_modules',
      \ 'npm-packages-offline-cache',
      \ 'opt',
      \ 'public',
      \ 'package',
      \ 'python3',
      \ 'tmp',
      \ ]

let g:test#go#gotest#executable = 'AWS_REGION=us-west-2 PRINT_LOGS=1 go test'
let g:test#go#gotest#options = '-v -count=1 -timeout=600s -vet=off'
let g:test#typescriptreact#runner = 'jest'
let g:test#javascript#jest#executable = 'yarn test'
let g:test#javascript#jest#options = ''
let g:dispatch_compilers = {}
let g:dispatch_compilers[g:test#go#gotest#executable] = 'go'
let g:dispatch_compilers[g:test#javascript#jest#executable] = g:test#typescriptreact#runner
let s:doSnapshot = 0

function! TestTransform(cmd) abort
  if s:doSnapshot == 1
    return a:cmd . ' -rewriteSnapshots'
  endif

  return a:cmd
endfunction

let g:test#custom_transformations = {'testTransform': function('TestTransform')}
let g:test#transformation = 'testTransform'

function! s:CoverageClear()
  let g:coverage_enabled = 0
  :CoverageClear
endfunction

" Delete the coverage file from the file system.
function! g:CoverageDelete()
  if filereadable(s:go_coverage_file)
    call delete(s:go_coverage_file)
  endif
endfunction

function! g:CoverageToggle()
  if &filetype ==# 'go'
    " nvim-coverage looks for go.mod in the current directory and up.
    execute 'cd' s:path_go
  endif
  if exists('g:coverage_enabled') && g:coverage_enabled == 1
    call s:CoverageClear()
  else
    let g:coverage_enabled = 1
    :Coverage
  endif
  if &filetype ==# 'go'
    " restore the project root for normal operation.
    execute 'cd' s:project_root
  endif
endfunction

function! Debug(confName = "Go Debug")
  echom "Launching debugger. " . a:confName
  call vimspector#LaunchWithSettings(#{ configuration: a:confName })
endfunction

function! s:TestSnapshot()
  let s:doSnapshot = 1
  call s:TestRun("Nearest", 0)
  let s:doSnapshot = 0
endfunction

function! s:TestRun(cmd, doCover) abort
  if &filetype ==# 'go'
    let g:test#project_root = s:path_go

    " PRINT_LOGS=1 go test -v -coverprofile=/home/ubuntu/co/backend/go/src/samsaradev.io/coverage.out -run 'TestStreamConnectorCRUD$' ./infra/api/gql/gqlapi
    if a:doCover == 1
      let l:options = g:test#go#gotest#options
      let g:test#go#gotest#options = g:test#go#gotest#options . ' -coverprofile=' . s:go_coverage_file
    endif
  elseif &filetype =~# 'typescript'
    if a:doCover == 1
      let l:options = g:test#javascript#jest#options
      let g:test#javascript#jest#options = g:test#javascript#jest#options . ' --no-cache --coverage'
    endif
  endif

  if a:doCover == 1
    call s:CoverageClear()
  endif

  execute 'Test' . a:cmd

  if &filetype ==# 'go'
    unlet g:test#project_root
    execute 'cd' s:project_root

    if a:doCover == 1
      let g:test#go#gotest#options = l:options
    endif
  elseif &filetype =~# 'typescript'
    if a:doCover == 1
      let g:test#javascript#jest#options = l:options
    endif
  endif
endfunction

function! s:TestDebugNearest()
  let l:position = s:TestGetPosition(expand('%'))
  let l:test_name = s:TestGetNearest(l:position)

  echom "Launching debugger. " . l:test_name
  call vimspector#LaunchWithSettings(#{ configuration: "Go Debug Test", Test: l:test_name })
endfunction

" See vim-test src
" https://github.com/vim-test/vim-test/blob/master/autoload/test.vim#L184-L193
function! s:TestGetPosition(path) abort
  let l:filename_modifier = get(g:, 'test#filename_modifier', ':.')

  let l:position = {}
  let l:position['file'] = fnamemodify(a:path, filename_modifier)
  let l:position['line'] = a:path == expand('%') ? line('.') : 1
  let l:position['col']  = a:path == expand('%') ? col('.') : 1

  return l:position
endfunction

" See vim-test src
" https://github.com/vim-test/vim-test/blob/master/autoload/test/go/gotest.vim#L56-L62
function! s:TestGetNearest(position) abort
  let l:name = test#base#nearest_test(a:position, g:test#go#patterns)
  let l:name = join(name['namespace'] + name['test'], '/')
  let l:without_spaces = substitute(name, '\s', '_', 'g')
  let l:escaped_regex = substitute(without_spaces, '\([\[\].*+?|$^()]\)', '\\\1', 'g')
  return l:escaped_regex
endfunction

nnoremap <silent><leader>xd :call Debug()<CR>
nnoremap <silent><leader>xt :call <SID>TestRun("Nearest", 0)<CR>
nnoremap <silent><leader>xtc :call <SID>TestRun("Nearest", 1)<CR>
nnoremap <silent><leader>xtcc :call <SID>TestRun("File", 1)<CR>
nnoremap <silent><leader>xtf :call <SID>TestRun("File", 0)<CR>
nnoremap <silent><leader>xtl :call <SID>TestRun("Last", 0)<CR>
nnoremap <silent><leader>xtd :call <SID>TestDebugNearest()<CR>
nnoremap <silent><leader>xts :call <SID>TestSnapshot()<CR>
" nnoremap <silent><leader>cc :call <SID>CoverageToggle()<CR>
" nnoremap <silent><leader>cd :call <SID>CoverageDelete()<CR>
" nnoremap <silent><leader>cs :CoverageSummary<CR>

nnoremap <silent><leader>ll <Plug>(ale_lint)
