# The Vim Configuration of Champions

## Installation

### Automatic

1. `bash <(curl -s https://raw.githubusercontent.com/dansomething/dot_vim/master/install)`
    * Note: This relies on [Homeshick](https://github.com/andsens/homeshick) for installation.
2. Enjoy enhanced productivity, increased levitation, reduced
   watermelon-related accidents, and startling sex appeal.

### Manual Steps
1. `git clone http://github.com/dansomething/dot_vim.git ~/dot_vim`
2. `ln -s ~/dot_vim/.vim ~/.vim`
3. `ln -s ~/.vim/vimrc ~/.vimrc`
4. `ln -s ~/.vim/gvimrc ~/.gvimrc`

## Screenshots

**MacVim**

[![MacVim][ss]][ss]

[ss]: https://raw.githubusercontent.com/mutewinter/dot_vim/master/screenshots/screenshot_1.png

## Requirements

**Mac**

 * [MacVim](http://macvim.org) - I'm currenty using
 the latest stable (9.0) from [Homebrew](http://brew.sh) on MacOS Sonoma.

## Bindings

* Typing `jk` insert mode is equivalent to `Escape`.
* Pressing `enter` in normal mode saves the current buffer.

And many more. See [`mappings.vim`](.vim/mappings.vim) and
[`plugins.vim`](.vim/plugins.vim) for more.

## Plugin Installation / Requirements

Add/Edit installed plugins in [`vim-plug.vim`](.vim/vim-plug.vim).
See [vim-plug](https://github.com/junegunn/vim-plug) to learn more about plugin configuration.

Here's a list of plugins that require further installation or have
dependencies.

* [Fugitive](https://github.com/tpope/vim-fugitive) Requires Git to be
  installed to be useful.
* [ALE](https://github.com/w0rp/ale) Requires many different
  binaries to be installed depending on what filetypes you want it to check. See the
  [Readme](https://github.com/w0rp/ale#supported-languages) for more information.
* [Hack (for Powerline)](https://git.io/vgUwx) The custom font I'm using
  for vim-airline.

## Plugin List

_Note: Auto generated by `rake plugins:update_readme`_


 * [ale](https://github.com/dense-analysis/ale) - Check syntax in Vim/Neovim asynchronously and fix files, with Language Server Protocol (LSP) support
 * [auto-pairs](https://github.com/jiangmiao/auto-pairs) - Vim plugin, insert or delete brackets, parens, quotes in pair
 * [coc-fzf](https://github.com/antoinemadec/coc-fzf) - fzf :heart: coc.nvim
 * [coc.nvim](https://github.com/neoclide/coc.nvim) - Nodejs extension host for vim & neovim, load extensions like VSCode and host language servers.
 * [diffconflicts](https://github.com/whiteinge/diffconflicts) - A better Vimdiff Git mergetool
 * [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim) - EditorConfig plugin for Vim
 * [fzf](https://github.com/junegunn/fzf) - :cherry_blossom: A command-line fuzzy finder
 * [fzf.vim](https://github.com/junegunn/fzf.vim) - fzf :heart: vim
 * [gv.vim](https://github.com/junegunn/gv.vim) - A git commit browser in Vim
 * [hexmode](https://github.com/fidian/hexmode) - Vim plugin to edit binary files in a hex mode automatically.
 * [jellybeans.vim](https://github.com/nanotech/jellybeans.vim) - A colorful, dark color scheme for Vim.
 * [ListToggle](https://github.com/Valloric/ListToggle) - A vim plugin for toggling the display of the quickfix list and the location-list.
 * [loupe](https://github.com/wincent/loupe) - 🔍 Enhanced in-file search for Vim
 * [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) - markdown preview plugin for (neo)vim
 * [nerdtree](https://github.com/scrooloose/nerdtree) - A tree explorer plugin for vim.
 * [QFEnter](https://github.com/yssl/QFEnter) - Open a Quickfix item in a window you choose. (Vim plugin)
 * [rainbow_parentheses.vim](https://github.com/kien/rainbow_parentheses.vim) - Better Rainbow Parentheses
 * [sideways.vim](https://github.com/AndrewRadev/sideways.vim) - A Vim plugin to move function arguments (and other delimited-by-something items) left and right.
 * [splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim) - Switch between single-line and multiline forms of code
 * [switch.vim](https://github.com/AndrewRadev/switch.vim) - A simple Vim plugin to switch segments of text with predefined replacements
 * [tmuxline.vim](https://github.com/edkolev/tmuxline.vim) - Simple tmux statusline generator with support for powerline symbols and statusline / airline / lightline integration
 * [undotree](https://github.com/mbbill/undotree) - The undo history visualizer for VIM
 * [vim-abolish](https://github.com/tpope/vim-abolish) - abolish.vim: Work with several variants of a word at once
 * [vim-addon-local-vimrc](https://github.com/MarcWeber/vim-addon-local-vimrc) - kiss local vimrc with hash protection
 * [vim-airline](https://github.com/vim-airline/vim-airline) - lean & mean status/tabline for vim that's light as air
 * [vim-airline-themes](https://github.com/vim-airline/vim-airline-themes) - A collection of themes for vim-airline
 * [vim-autoformat](https://github.com/Chiel92/vim-autoformat) - Provide easy code formatting in Vim by integrating existing code formatters.
 * [vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace) - Better whitespace highlighting for Vim
 * [vim-commentary](https://github.com/tpope/vim-commentary) - commentary.vim: comment stuff out
 * [vim-css-color](https://github.com/ap/vim-css-color) - Preview colours in source code while editing
 * [vim-dispatch](https://github.com/tpope/vim-dispatch) - dispatch.vim: Asynchronous build and test dispatcher
 * [vim-easymotion](https://github.com/easymotion/vim-easymotion) - Vim motions on speed!
 * [vim-eunuch](https://github.com/tpope/vim-eunuch) - eunuch.vim: Helpers for UNIX
 * [vim-fugitive](https://github.com/tpope/vim-fugitive) - fugitive.vim: A Git wrapper so awesome, it should be illegal
 * [vim-go-syntax](https://github.com/charlespascoe/vim-go-syntax) - Fast, 'tree-sitter'-like Vim Syntax Highlighting for Go
 * [vim-hackernews](https://github.com/dansomething/vim-hackernews) - Hacker News plugin for Vim (formerly ryanss/vim-hackernews)
 * [vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides) - A Vim plugin for visually displaying indent levels in code
 * [vim-lion](https://github.com/tommcdo/vim-lion) - A simple alignment operator for Vim text editor
 * [vim-matchup](https://github.com/andymass/vim-matchup) - vim match-up: even better % :facepunch: navigate and highlight matching words :facepunch: modern matchit and matchparen.  Supports both vim and neovim + tree-sitter.
 * [vim-obsession](https://github.com/tpope/vim-obsession) - obsession.vim: continuously updated session files
 * [vim-peekaboo](https://github.com/junegunn/vim-peekaboo) - :eyes: " / @ / CTRL-R
 * [vim-polyglot](https://github.com/sheerun/vim-polyglot) - A solid language pack for Vim.
 * [vim-repeat](https://github.com/tpope/vim-repeat) - repeat.vim: enable repeating supported plugin maps with "."
 * [vim-rhubarb](https://github.com/tpope/vim-rhubarb) - rhubarb.vim: GitHub extension for fugitive.vim
 * [vim-signify](https://github.com/mhinz/vim-signify) - :heavy_plus_sign: Show a diff using Vim its sign column.
 * [vim-snippets](https://github.com/honza/vim-snippets) - vim-snipmate default snippets (Previously snipmate-snippets)
 * [vim-surround](https://github.com/tpope/vim-surround) - surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with ease
 * [vim-test](https://github.com/janko-m/vim-test) - Run your tests at the speed of thought
 * [vim-tmux-focus-events](https://github.com/tmux-plugins/vim-tmux-focus-events) - Make terminal vim and tmux work better together.
 * [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - Seamless navigation between tmux panes and vim splits
 * [vim-togglecursor](https://github.com/jszakmeister/vim-togglecursor) - Toggle the cursor shape in the terminal for Vim.
 * [vim-unimpaired](https://github.com/tpope/vim-unimpaired) - unimpaired.vim: Pairs of handy bracket mappings
 * [vim-wipeout](https://github.com/artnez/vim-wipeout) - Destroy all buffers that are not open in any tabs or windows.
 * [vim-zoom](https://github.com/dhruvasagar/vim-zoom) - Toggle zoom in / out individual windows (splits)
 * [vimspector](https://github.com/puremourning/vimspector) - vimspector - A multi-language debugging system for Vim
 * [vista.vim](https://github.com/liuchengxu/vista.vim) - :cactus: Viewer & Finder for LSP symbols and tags

_That's 57 plugins, holy crap._
