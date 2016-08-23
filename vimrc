setglobal nocompatible
execute pathogen#infect()
set nu ai
colo desert
if has('gui_running')
	set guifont=Monospace\ 12
end

inoremap <F5> <C-o>:tabprevious<Return>
nnoremap <F5> :tabprevious<Return>
inoremap <F8> <C-o>:tabnext<Return>
nnoremap <F8> :tabnext<Return>
inoremap <F6> <C-o>:bprevious<Return>
nnoremap <F6> :bprevious<Return>
inoremap <F7> <C-o>:bnext<Return>
nnoremap <F7> :bnext<Return>

autocmd FileType lisp setlocal tabstop=2 softtabstop=0 shiftwidth=2 noexpandtab cindent cinoptions=(2U1 equalprg=~/.local/libexec/stupid-lisp-indent.pl
autocmd FileType erb,javascript,ruby,haml,sass,scss,gitcommit setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType haml,sass setlocal copyindent
autocmd BufNewFile,BufRead ~/projects/work/techyes3/** setlocal tags=~/projects/work/techyes3/tags

com! -complete=file -nargs=* Tabe silent! exec "!vim --servername " . v:servername . " --remote-tab-silent <args>"

set exrc
set modeline

autocmd FileType mail setlocal textwidth=72
