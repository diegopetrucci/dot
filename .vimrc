syntax enable " Enable syntax highlighting (keeps your color settings)
filetype plugin on " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown " Treat .md files as .markdown
:set relativenumber " Show the relative line numbers
