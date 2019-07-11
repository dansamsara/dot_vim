" ----------------------------------------
" vim-plug
" ----------------------------------------

" auto install vim-plug and plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" ---------------
" Plug Bundles
" ---------------

" Navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'dhruvasagar/vim-zoom'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-bash --no-zsh --no-fish' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'
" UI Additions
Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'sass', 'scss'] }
Plug 'edkolev/tmuxline.vim'
Plug 'jszakmeister/vim-togglecursor'
Plug 'junegunn/vim-peekaboo'
Plug 'kien/rainbow_parentheses.vim'
Plug 'liuchengxu/vista.vim', { 'on':  ['Vista'] }
Plug 'ludovicchabant/vim-gutentags'
Plug 'mbbill/undotree', { 'on':  ['UndotreeShow', 'UndotreeToggle'] }
Plug 'mhinz/vim-signify'
Plug 'nanotech/jellybeans.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'samsonw/vim-task', { 'for': 'task' }
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'yssl/QFEnter'
" Commands
Plug 'AndrewRadev/sideways.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'Valloric/ListToggle'
Plug 'dansomething/vim-eclim'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-slash'
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'mtth/scratch.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive', { 'tag': '*' }
Plug 'tpope/vim-surround'
Plug 'vim-scripts/UnconditionalPaste'
" Automatic Helpers
Plug 'Chiel92/vim-autoformat'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'andymass/vim-matchup'
Plug 'editorconfig/editorconfig-vim'
Plug 'epilande/vim-es2015-snippets'
Plug 'epilande/vim-react-snippets'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'janko-m/vim-test'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'tag': '*'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'w0rp/ale'
Plug 'whiteinge/diffconflicts'
" Language Additions
Plug 'sheerun/vim-polyglot'
"   Clojure
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'guns/vim-slamhound', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-projectionist', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
" Misc
Plug 'dansomething/vim-hackernews', { 'on': 'HackerNews' }

" Add plugins to &runtimepath
call plug#end()
