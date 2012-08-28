" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

call pathogen#infect()
syntax on
filetype plugin indent on
