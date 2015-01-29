# The Vim Configuration of Champions

## Installation


1. `bash <(curl -s https://raw.githubusercontent.com/dansomething/dot_vim/master/install)`
    * Note: This relies on [Homeshick](https://github.com/andsens/homeshick) for installation.
2. Enjoy enhanced productivity, increased levitation, reduced
   watermelon-related accidents, and startling sex appeal.

### Manual Install
1. `git clone http://github.com/dansomething/dot_vim.git ~/.vim`
2. `ln -s ~/.vim/vimrc ~/.vimrc`
3. `ln -s ~/.vim/gvimrc ~/.gvimrc`
4. Install [Vundle](https://github.com/gmarik/vundle) with `git clone
   http://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
5. `vim +PluginInstall +qall` _installs all of the plugins_
6. `~/.vim/bundle/YouCompleteMe/install.sh --clang-completer`

## Screenshots

**MacVim**

[![MacVim][ss]][ss]

[ss]: https://raw.githubusercontent.com/mutewinter/dot_vim/master/screenshots/iTerm.png

## Requirements

**Mac**

 * [MacVim](http://code.google.com/p/macvim/) - I'm currenty using
 the latest stable (7.4-71) from [Homebrew](http://brew.sh) on Mavericks.

## Bindings

* Typing `jk` insert mode is equivalent to `Escape`.
* Pressing `enter` in normal mode saves the current buffer.

And many more. See [`bindings.vim`](bindings.vim) and
[`plugins.vim`](plugins.vim) for more.

## Notes

Be sure to always edit the vimrc using `,v`, which opens the vimrc in the .vim
folder. Vim has a nasty habit of overriding symlinks.

## Plugin Installation / Requirements

Here's a list of plugins that require further installation or have
dependencies.

* [Fugitive](https://github.com/tpope/vim-fugitive) Requires Git to be
  installed.
* [syntastic](https://github.com/scrooloose/syntastic) Requires many different
  binaries installed depending on what filetypes you want it to check. See the
  [FAQ](https://github.com/scrooloose/syntastic#faq) for more information.
* [Ag.vim](https://github.com/rking/ag.vim) Requires
  [The Silver Searcher](https://github.com/ggreer/the_silver_searcher) to be
  installed.
* [Source Code for Powerline](http://git.io/H3fYBg) The custom font I'm using
  for vim-airline.
* [CtrlP C Matching Extension](https://github.com/JazzCore/ctrlp-cmatcher)
  requires compilation. See the steps [in its
  readme](https://github.com/JazzCore/ctrlp-cmatcher).

## Plugin List

_Note: Auto generated by `rake plugins:update_readme`_


 * [ag.vim](https://github.com/rking/ag.vim) - Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module / CLI script 'ack'
 * [angular-vim-snippets](https://github.com/matthewsimo/angular-vim-snippets) - repo for UltiSnips & Snipmate for angular to be included as a submodule for use in your .vim directory
 * [colorv.vim](https://github.com/Rykka/colorv.vim) - A powerful color tool in vim
 * [ctrlp.vim](https://github.com/kien/ctrlp.vim) - Fuzzy file, buffer, mru, tag, etc finder.
 * [dash.vim](https://github.com/rizzatti/dash.vim) - Search Dash.app from Vim
 * [delimitMate](https://github.com/Raimondi/delimitMate) - Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
 * [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim) - EditorConfig plugin for Vim
 * [emmet-vim](https://github.com/mattn/emmet-vim) - emmet for vim: http://emmet.io/
 * [ftl-vim-syntax](https://github.com/dansomething/ftl-vim-syntax) - Vim syntax for FTL (FreeMarker Template Language)
 * [HelpClose](https://github.com/vim-scripts/HelpClose) - Close all help windows
 * [html5.vim](https://github.com/othree/html5.vim) - HTML5 omnicomplete and syntax
 * [indenthtml.vim](https://github.com/vim-scripts/indenthtml.vim) - alternative html indent script
 * [javascript-libraries-syntax.vim](https://github.com/othree/javascript-libraries-syntax.vim) - Syntax for JavaScript libraries
 * [jellybeans.vim](https://github.com/nanotech/jellybeans.vim) - A colorful, dark color scheme for Vim.
 * [matchit.zip](https://github.com/vim-scripts/matchit.zip) - extended % matching for HTML, LaTeX, and many other languages
 * [MatchTagAlways](https://github.com/Valloric/MatchTagAlways) - A Vim plugin that always highlights the enclosing html/xml tags
 * [nerdcommenter](https://github.com/scrooloose/nerdcommenter) - Vim plugin for intensely orgasmic commenting
 * [nerdtree](https://github.com/scrooloose/nerdtree) - A tree explorer plugin for vim.
 * [rainbow_parentheses.vim](https://github.com/kien/rainbow_parentheses.vim) - Better Rainbow Parentheses
 * [scratch.vim](https://github.com/vim-scripts/scratch.vim) - Plugin to create and use a scratch Vim buffer
 * [sideways.vim](https://github.com/AndrewRadev/sideways.vim) - A Vim plugin to move function arguments (and other delimited-by-something items) left and right.
 * [splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim) - A vim plugin that simplifies the transition between multiline and single-line code
 * [supertab](https://github.com/ervandew/supertab) - Perform all your vim insert mode completions with Tab
 * [switch.vim](https://github.com/AndrewRadev/switch.vim) - A simple Vim plugin to switch segments of text with predefined replacements
 * [syntastic](https://github.com/scrooloose/syntastic) - Syntax checking hacks for vim
 * [SyntaxComplete](https://github.com/vim-scripts/SyntaxComplete) - OMNI Completion based on the current syntax highlights
 * [tabular](https://github.com/godlygeek/tabular) - Vim script for text filtering and alignment
 * [tagbar](https://github.com/majutsushi/tagbar) - Vim plugin that displays tags in a window, ordered by scope
 * [tmuxline.vim](https://github.com/edkolev/tmuxline.vim) - Simple tmux statusline generator with support for powerline symbols and statusline / airline / lightline integration
 * [ultisnips](https://github.com/SirVer/ultisnips) - UltiSnips - The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips!
 * [UnconditionalPaste](https://github.com/mutewinter/UnconditionalPaste) - A clone of UnconditionalPaste from http://www.vim.org/scripts/script.php?script_id=3355 since it's not updated on GitHub yet.
 * [undotree](https://github.com/mbbill/undotree) - Display your undo history in a graph.
 * [vim-abolish](https://github.com/tpope/vim-abolish) - abolish.vim: easily search for, substitute, and abbreviate multiple variants of a word
 * [vim-addon-local-vimrc](https://github.com/MarcWeber/vim-addon-local-vimrc) - kiss local vimrc with hash protection
 * [vim-airline](https://github.com/bling/vim-airline) - lean & mean status/tabline for vim that's light as air
 * [vim-clojure-highlight](https://github.com/guns/vim-clojure-highlight) - Extend builtin syntax highlighting to referred and aliased vars in Clojure buffers
 * [vim-clojure-static](https://github.com/guns/vim-clojure-static) - Meikel Brandmeyer's excellent Clojure runtime files
 * [vim-coffee-script](https://github.com/kchmck/vim-coffee-script) - CoffeeScript support for vim
 * [vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax) - Add CSS3 syntax support to vim's built-in `syntax/css.vim`.
 * [vim-cucumber](https://github.com/tpope/vim-cucumber) - Vim Cucumber runtime files
 * [vim-dispatch](https://github.com/tpope/vim-dispatch) - dispatch.vim: asynchronous build and test dispatcher
 * [vim-easymotion](https://github.com/Lokaltog/vim-easymotion) - Vim motions on speed!
 * [vim-eclim](https://github.com/dansomething/vim-eclim) - Mirror of the VIM files from https://github.com/ervandew/eclim to support installation via Vundle.
 * [vim-eunuch](https://github.com/tpope/vim-eunuch) - eunuch.vim: helpers for UNIX
 * [vim-fireplace](https://github.com/tpope/vim-fireplace) - fireplace.vim: Clojure REPL support
 * [vim-fugitive](https://github.com/tpope/vim-fugitive) - fugitive.vim: a Git wrapper so awesome, it should be illegal
 * [vim-gradle](https://github.com/tfnico/vim-gradle) - Simple little vim-bundle that recognizes .gradle files as being groovy syntax
 * [vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides) - A Vim plugin for visually displaying indent levels in code
 * [vim-javascript](https://github.com/pangloss/vim-javascript) - Vastly improved Javascript indentation and syntax support in Vim.
 * [vim-json](https://github.com/elzr/vim-json) - A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing. Pathogen-friendly.
 * [vim-leiningen](https://github.com/tpope/vim-leiningen) - leiningen.vim: static support for Leiningen
 * [vim-less](https://github.com/groenewege/vim-less) - vim syntax for LESS (dynamic CSS)
 * [vim-mustache-handlebars](https://github.com/mustache/vim-mustache-handlebars) - mustache and handlebars mode for vim
 * [vim-obsession](https://github.com/tpope/vim-obsession) - obsession.vim: continuously updated session files
 * [vim-projectionist](https://github.com/tpope/vim-projectionist) - projectionist.vim: project configuration
 * [vim-repeat](https://github.com/tpope/vim-repeat) - repeat.vim: enable repeating supported plugin maps with "."
 * [vim-sexp](https://github.com/guns/vim-sexp) - Precision Editing for S-expressions
 * [vim-sexp-mappings-for-regular-people](https://github.com/tpope/vim-sexp-mappings-for-regular-people) - vim-sexp mappings for regular people
 * [vim-signify](https://github.com/mhinz/vim-signify) - Show a VCS diff using Vim's sign column.
 * [vim-slamhound](https://github.com/guns/vim-slamhound) - Slamhound integration for vim.
 * [vim-snippets](https://github.com/dansomething/vim-snippets) - vim-snipmate default snippets (Previously snipmate-snippets)
 * [vim-space](https://github.com/christoomey/vim-space) - space.vim - Smart Space key for Vim
 * [vim-startify](https://github.com/mhinz/vim-startify) - A fancy start screen for Vim.
 * [vim-surround](https://github.com/tpope/vim-surround) - surround.vim: quoting/parenthesizing made simple
 * [vim-tags](https://github.com/szw/vim-tags) - Ctags generator for Vim
 * [vim-task](https://github.com/samsonw/vim-task) - vim task plugin
 * [vim-tmux](https://github.com/tmux-plugins/vim-tmux) - vim plugin for tmux.conf
 * [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - Seamless navigation between tmux panes and vim splits
 * [vim-togglecursor](https://github.com/jszakmeister/vim-togglecursor) - Toggle the cursor shape in the terminal for Vim.
 * [vim-togglelist](https://github.com/milkypostman/vim-togglelist) - Functions to toggle the [Location List] and the [Quickfix List] windows.
 * [vim-unimpaired](https://github.com/tpope/vim-unimpaired) - unimpaired.vim: pairs of handy bracket mappings
 * [vim-visual-star-search](https://github.com/dansomething/vim-visual-star-search) - Start a * or # search from a visual block
 * [Vundle.vim](https://github.com/gmarik/Vundle.vim) - Vundle, the plug-in manager for Vim
 * [ZoomWin](https://github.com/regedarek/ZoomWin) - Zoom in/out  of windows (toggle between one window and multi-window)

_That's 74 plugins, holy crap._
