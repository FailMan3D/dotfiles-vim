setglobal nocompatible
execute pathogen#infect()
set number autoindent
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

inoremap <F10> <C-o>:stselect<Return>
nnoremap <F10> <C-o>:stselect<Return>

augroup type_specific_overrides
	au!
	autocmd FileType lisp setlocal tabstop=2 softtabstop=0 shiftwidth=2 noexpandtab cindent cinoptions=(2U1 equalprg=~/.local/libexec/stupid-lisp-indent.pl
	autocmd FileType erb,javascript,ruby,haml,sass,scss,gitcommit setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
	autocmd FileType haml,sass setlocal copyindent

	function! SetTagfileBecauseAutocmdSucksAtPatternExpansion()
		let l:f = resolve(expand("%:p:h"))
		let l:real_home = resolve(expand($HOME) . "/projects/work/")
		if l:f =~ "^" . l:real_home
			let l:tf_path = l:real_home . "/" . substitute(substitute(l:f, l:real_home . "/", "", ""), "/.*$", "", "") . "/tags"
			let &l:tags=l:tf_path
		endif
	endfunction
	autocmd BufNewFile,BufRead ~/projects/work/*/** call SetTagfileBecauseAutocmdSucksAtPatternExpansion()
augroup END

com! -complete=file -nargs=* Tabe silent! exec "!vim --servername " . v:servername . " --remote-tab-silent <args>"

" set exrc
set modeline

"""
""" Post-modeline overrides
"""
augroup post_modeline_overrides
	au!
	autocmd FileType mail setlocal textwidth=72 " mutt *really* wants this
	autocmd FileType plperl setlocal syntax=sql " embedded Perl syntax is provided by SyntaxRange call later in vimrc
augroup END

augroup syntax_subregion_markers
	au!
	autocmd BufNewFile,BufRead * call SyntaxRange#Include('#\[begsyn perl\]', '#\[endsyn perl\]', 'perl', 'NonText')
	autocmd BufNewFile,BufRead * call SyntaxRange#Include('--\[begsyn sql\]', '--\[endsyn sql\]', 'sql', 'NonText')
	autocmd BufNewFile,BufRead * call SyntaxRange#Include('--\[begsyn plsql\]', '--\[endsyn plsql\]', 'plsql', 'NonText')
augroup END

" https://sanctum.geek.nz/arabesque/local-vimrc-files/
if filereadable(glob("~/.vimrc.local"))
	source ~/.vimrc.local
end
