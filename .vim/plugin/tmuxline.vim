"edkolev/tmuxline.vim

let g:tmuxline_preset = {
    \ 'a'    : '❐ #S',
    \ 'b'    : '#H',
    \ 'c'    : '#(whoami)',
    \ 'win'  : ['#I', '#W'],
    \ 'cwin' : ['#I', '#W'],
    \ 'x'    : ['%I:%M %p'],
    \ 'y'    : '⚡️ #(battery)',
    \ 'z'    : '#(tmux-mem-cpu-load -a0)'
    \ }
