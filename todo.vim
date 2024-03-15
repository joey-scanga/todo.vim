function! SetupTodos()
	setlocal foldmethod=indent
	setlocal shiftwidth=2
	nnoremap <leader>z :call ToggleCheckMark()<CR>
	silent! AnsiEsc
endfunction

function! ToggleCheckMark()
	let pos = getpos('.')[1]
	if stridx(getline(pos), '☐') > -1
		call setline(pos, substitute(getline(pos), '31m☐', '32m☑', '') . " \| " . strftime("%Y %b %d %X"))
	elseif stridx(getline(pos), '☑') > -1
		call setline(pos, substitute(getline(pos), '32m☑', '31m☐', ''))
		norm mq0f|d$`q
	else
		let line = matchstr(getline(pos), '\w.*')
		call setline(pos, repeat(' ', indent(pos)) .. "\e\[31m☐\e\[0m " .. line)
	endif
endfunction

augroup todo
	au!
	au BufLeave *.todo echon '' | silent! AnsiEsc
	au BufEnter *.todo call SetupTodos()
augroup END
