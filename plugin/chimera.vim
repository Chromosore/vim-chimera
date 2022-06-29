" vim-chimera - clear search matches automatically
" Prelude [[[1
if exists('g:loaded_chimera') && g:loaded_chimera
	finish
endif
let s:save_cpo = &cpo
set cpo&vim
" ]]]
let g:loaded_chimera = 1

let s:skip = 0

fun! s:update()
	if !v:hlsearch || mode() isnot 'n' | return | endif

	if s:skip > 0
		let s:skip -= 1
		return
	endif

	call s:nohlsearch()
endfun

noremap  <silent> <Plug>(chimera-nohl) :<C-U>nohlsearch<CR>
noremap! <expr>   <Plug>(chimera-nohl) execute('nohlsearch')[-1]

fun! s:nohlsearch()
	if !v:hlsearch || mode() isnot 'n' | return | endif
	silent call feedkeys("\<Plug>(chimera-nohl)", 'm')
endfun

fun! s:skip_one()
	let s:skip += 1
	return ''
endfun

noremap  <expr> <Plug>(chimera-skip) <SID>skip_one()
noremap! <expr> <Plug>(chimera-skip) <SID>skip_one()


for key in ['/', '?', 'n', 'N', '*', 'g*', '#', 'g#']
	exec printf(':noremap <Plug>(chimera-%s) %s', key, key)
endfor


if get(g:, 'chimera_do_mappings', 1)
	for key in ['/', '?', 'n', 'N', '*', 'g*', '#', 'g#']
		exec printf(':nmap %s <Plug>(chimera-skip)<Plug>(chimera-%s)', key, key)
		exec printf(':omap %s <Plug>(chimera-skip)<Plug>(chimera-%s)', key, key)
		exec printf(':xmap %s <Plug>(chimera-skip)<Plug>(chimera-%s)', key, key)
	endfor
endif

augroup Chimera
	au!
	au CursorMoved * call s:update()
	au InsertEnter * call s:nohlsearch()
augroup end


" &cpo and modeline [[[1
let &cpo = s:save_cpo
unlet s:save_cpo
" vim: fdm=marker fmr=[[[,]]]
