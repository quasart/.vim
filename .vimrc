"""""""""""""""""""""""""""
"         GENERAL         "
",,,,,,,,,,,,,,,,,,,,,,,,,"

set nocompatible

"remove all autocmd
autocmd!

filetype plugin on
filetype indent on

set nobackup
set writebackup "remove backup after file write
set noswapfile




"""""""""""""""""""""""""""
"         DISPLAY         "
",,,,,,,,,,,,,,,,,,,,,,,,,"

syntax on
colorscheme elflord
highlight SpecialKey cterm=bold ctermfg=0
highlight Search ctermbg=yellow ctermfg=black
highlight CursorLine cterm=none ctermbg=black

set encoding=utf8

set linebreak "doesn't break words
set display=lastline "always display the last line

set listchars=tab:»_,trail:• "format of non-printable char (to use with :set list)
set list
set matchpairs=(:),{:},[:],<:>

set number "num de ligne
set ruler "display cursor coordinates
set laststatus=2 "display status bar
set statusline=[%02n]%*\ %f\ %(%m%)%(%r%)%*%=%b\ 0x%B\ \ <%l,%c%V>\ %P
set report=0 "always display nb of modification
set shortmess-=f
set showcmd "show cmd while typing, and size of visual selection

set wildmenu
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz
set suffixes=.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar,.pdf



"""""""""""""""""""""""""""
"       INDENT/EOL        "
",,,,,,,,,,,,,,,,,,,,,,,,,"

set noexpandtab

set tabstop=4 "tab correspond a 4 espaces
set softtabstop=4
set shiftwidth=4
set shiftround
set smarttab "use tabs at the start of a line, spaces elsewhere

set autoindent
set smartindent
set cindent


set backspace=indent,eol,start "backspace everything
set textwidth=0 "automatic line return for long lines

"set virtualedit=all "allow edit after end of line
"set ffs=unix,mac,dos





""""""""""""""""""""""""""""
"          SEARCH          "
",,,,,,,,,,,,,,,,,,,,,,,,,,"

set ignorecase "make searches case-insensitive
set smartcase  "unless they contain upper-case letters

set incsearch "display search while typing

set hlsearch "highlight search results

set gdefault "multiple subs in a line


set grepprg=grep\ -n\ --directories=skip
if has("win32")
	set grepprg=internal
end


"""""""""""""""""""""""""""
"          DIFF           "
",,,,,,,,,,,,,,,,,,,,,,,,,"

highlight DiffDelete cterm=none ctermfg=black ctermbg=red
highlight DiffAdd    cterm=bold ctermbg=green
highlight DiffText   cterm=bold ctermbg=green
highlight DiffChange cterm=bold ctermbg=blue

set diffopt=filler,iwhite,context:20

if &diff
	set nolist
endif


""""""""""""""""""""""""""
"        KEY MAPS        "
",,,,,,,,,,,,,,,,,,,,,,,,"


imap <F1> <Esc><Esc>
map <F1> <Esc><Esc>

" french keyboard
nmap é ~
vmap é ~
nmap µ :noh<CR>
"nmap è `
"nmap ç ^
nmap à @q
"nmap ù %
"nmap € ?

" Putty keyboard
map [25~ <S-F3>
map [29~ <S-F6>
map [31~ <S-F7>
map [32~ <S-F8>

" dont overwrite default register
vnoremap p "_c<Esc>p
nnoremap <del> "_x


" buffers
nmap <S-TAB> :bnext<CR>
imap <S-TAB> <ESC>:bnext<CR>
nmap <silent> <F10> :Bclose<CR>h
nmap ² <C-^>

" save/make/debug
nmap <F5> :update<CR>
imap <F5> <Esc><F5>
nmap <F6> :make<CR>
nmap <S-F6> :cwindow<CR>
nmap <F8> :cn<CR>
nmap <S-F8> :cp<CR>


" show whitespace
nmap <F12> :set list!<CR>
imap <F12> <C-o><F12>
nmap <S-F12> /[\r \t]\+$/<CR>
vmap <F12>    :s/[\r \t]\+$//<CR>
"nmap <silent> <F12> :call ToggleListChars()<CR>
"function! ToggleListChars()
"	if &list == 0
"		set listchars=tab:»_,trail:•,nbsp:%
"		set list
"		echon "list all"
"	else
"		if &listchars=='tab:»_,trail:•,nbsp:%'
"			set listchars=tab:»\ ,trail:·
"			echon "list tabs"
"		else
"			set listchars= 
"			set list!
"			echon "list none"
"		endif
"	endif
"endfunction


" quick recording replay (with q register)
nmap Q @q


" spell
if version >= 700
	nmap <F3> :set spell!<CR>
	map <S-F3> z=
endif

" search for selection. url:http://vim.sf.net/tips/tip.php?tip_id=780
vmap <silent> * "gy/<C-R>=substitute( escape(@g, '\\/.*$^~[]'), "[ \t\n]\\+", '\\_s\\+', 'g' )<CR><CR>
vmap <silent> # "gy?<C-R>=substitute( escape(@g, '\\/.*$^~[]'), "[ \t\n]\\+", '\\_s\\+', 'g' )<CR><CR>


" aligne en colonne
vmap <silent> + :s:[\t ]\+: :e<CR>:noh<CR>gv:!column -s" " -t<CR>gv=


" grep
"nmap § :grep '' * */*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nmap § :grep -r '' *<LEFT><LEFT><LEFT>
vmap § "gy§<C-r>g


" CTRL-A extension : change cursor according to dictionary
map <C-a> :call <SID>ExtendedCtrlA()<CR>

let g:auto_next_dictionary = {
			\ 'true'   :  'false' ,
			\ 'false'  :  'true'  ,
			\ 'yes'    :  'no'    ,
			\ 'no'     :  'yes'   ,
			\ 'On'     :  'Off'   ,
			\ 'Off'    :  'On'    ,
			\ 'on'     :  'off'   ,
			\ 'off'    :  'on'    }
function! s:ExtendedCtrlA()
	let my_cword = expand("<cword>")
	if get(g:auto_next_dictionary,my_cword,'NotFound') == 'NotFound'
		exe "normal! \<C-A>"
	else
		exe "normal! \"hciw\<C-R>=g:auto_next_dictionary['\<C-R>h']\<CR>\<ESC>"
	endif
endfunction


" comment/uncomment
let b:my_comment_token='#'
autocmd FileType cc,c,cpp,c++,h,hpp,js,php      let b:my_comment_token='//'
autocmd FileType sql                            let b:my_comment_token='--'
autocmd FileType vim,vimrc                      let b:my_comment_token='"'
autocmd FileType xml,html,htm                   let b:my_comment_token='<!--  -->'

noremap <F7> :s+^+<C-R>=b:my_comment_token<CR>+e<CR>:noh<CR>
noremap <S-F7> :s+^\(\s*\)<C-R>=b:my_comment_token<CR>+\1+e<CR>:noh<CR>
inoremap <F7> <esc>"=&commentstring<CR>pF%"_c2<right>


" home moves cursor -> ^ -> 0
imap <HOME> <C-o>:call <SID>HomeLikeVCpp()<CR>
nmap <HOME> :call <SID>HomeLikeVCpp()<CR>

function! s:HomeLikeVCpp()
	let ll = strpart(getline('.'), -1, col('.'))
	if ll =~ '^\s\+$' | normal! 0
	else | normal! ^
	endif
endfunction


" bracket selection
vmap <silent> ( "hc()<ESC>P
vmap <silent> [ "hc[]<ESC>P


"exit insert mode on double-click (following copy/paste expected)
inoremap <2-LeftMouse> <esc>viw





""""""""""""""""""""""""""""""""
"     NETRW : FILE BROWSER     "
",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"

let g:netrw_browse_split=4 "previous windows as default
let g:netrw_preview=1 "vsplit as default
let g:netrw_banner=0 "disable banner
let g:netrw_liststyle=3 "tree linsting
let g:netrw_winsize=-220

let g:netrw_list_hide= '^\.[^\.].*' " to hide .* files
let g:netrw_hide=0

let g:netrw_sort_sequence='[\/]$,*' " directories first
"let g:netrw_sort_sequence='[\/]$,\.h\(pp\)\?\*\?$,\.c\(pp\)\?\*\?$,Makefile*,*,version\.h' "hpp/cpp first
let g:netrw_sort_options="i" " ignore case in sort

let g:netrw_dirhistmax=0 "disable history
let g:netrw_use_errorwindow    = 1


"unload original buffer (to avoid it when using :bnext)
autocmd VimEnter NetrwTreeListing\ 1         bd 1

"quit problem workaround
function! QuitNetrw()
	for i in range(1, bufnr($))
		if buflisted(i)
			if getbufvar(i, '&filetype') == "netrw"
				silent exe 'bwipeout ' . i
			endif
		endif
	endfor
endfunction
autocmd VimLeavePre *  call QuitNetrw()




""""""""""""""""""""""
"        GUI         "
",,,,,,,,,,,,,,,,,,,,"

if has('gui_running')
	colorscheme desert
	set cursorline
	highlight CursorLine guibg=#292929
	highlight SpecialKey guifg=#304040
	highlight Normal     guibg=#222222
	set guifont=Monospace,Consolas:h10:cANSI

	set guioptions-=T "no toolbar
	set linespace=1 "interligne
	set numberwidth=4 "not in vi
	set lines=50 columns=150

	" Menu
	an &MyTools.Search\ &Long\ Lines /.\{73}<CR>
	an &MyTools.Delete\ &End-of-line\ Spaces :%s:\s+$::<CR>
	an &MyTools.&Rot13 ggVGg?
	an &MyTools.&dos2unix :%s:\r::<CR>
	an &MyTools.&Windows\ Easy\ Mode :source C:\Program Files (x86)\Vim\vim74\evim.vim<CR>

	" windows copy/paste
	vmap <C-c> "+y
	vmap <C-v> "+p

	" Tabs
	"set showtabline=1
else
	set mouse=a
	set ttymouse=urxvt "to enable mouse on wide screens
	map <F2> :call ToggleMouse()<CR>
	imap <F2> <C-O>:call ToggleMouse()<CR>
end

function! ToggleMouse()
	if &mouse == ''
		set mouse=a
		set number
		set nopaste
	else
		set mouse=
		set nonumber
		set paste
		set nolist
	endif
	echon "mouse=" &mouse
endfunction






"""""""""""""""""""""""
"       AUTOCMD       "
",,,,,,,,,,,,,,,,,,,,,"

" remember file position
autocmd BufReadPost *          if line("'\"") > 0 && line("'\"") <= line("$") && ! &diff
						\ |      exe "normal g`\""
						\ |    endif

" load vimrc when modified
autocmd! bufwritepost .vimrc   source %


" load skeleton when creating a new file
autocmd BufNewFile  *.sh       0read ~/.vim/skeleton.sh
						\ |    normal G


" different background color on insert mode
autocmd InsertEnter * highlight Normal ctermbg=black
autocmd InsertLeave * highlight Normal ctermbg=none

"auto exit insert mode after a while
autocmd CursorHoldI * stopinsert
autocmd InsertEnter * let updaterestore=&updatetime | set updatetime=7000
autocmd InsertLeave * let &updatetime=updaterestore






"""""""""""""""""""""""""""""
"       FILE SPECIFIC       "
",,,,,,,,,,,,,,,,,,,,,,,,,,,"




""""""" C/C++

" if block
autocmd FileType cc,c,cpp,c++,h,hpp vmap <silent> i
			\ :<C-U>'<put! ='if () {'<CR>
			\:'>put ='}'<CR>
			\:'<-1<CR>==
			\:'>+1<CR>==
			\gv>
			\:'<-1<CR>f{i<CR><ESC>kff3li

"set errorformat=%f:%l:\ error:\ %m






"""""""" xml/html

"inline xml tag
autocmd FileType xml,html,htm,rb,erb,php vmap <silent> h
			\ "hdi<__HTML_TAG__></__HTML_TAG__><esc>14h"hP
			\:s/__HTML_TAG__/

"multiline xml tag
autocmd FileType xml,html,htm,rb,erb,php vmap <silent> H
			\ :<C-U>'<put! ='<__HTML_TAG__>'<CR>
			\:'>put ='</__HTML_TAG__>'<CR>
			\:'<-1<CR>==
			\gv>
			\:'>+1<CR>==
			\:'<-1,'>+1s/__HTML_TAG__/


autocmd FileType xml,html,htm,erb,php,txt imap lorem
			\ Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed doo eiusmod tempor incididunt ut labore et dolore magna aliqua.
			\ Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip exa ea commodo consequat.
			\ Duis aute irure dolor ine reprehenderit ini voluptate velit esse cillum dolore eu fugiat nulla pariatur.
			\ Excepteur sint occaecat cupidatat non proident, sunt inu culpa quoi officia deserunt mollit anim id est laborum.




"""""""" php/rails

autocmd FileType html,htm,rb,erb,php set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

autocmd FileType php       imap <? <?php  ?><LEFT><LEFT><LEFT>
autocmd FileType erb,eruby imap <% <%  %><LEFT><LEFT><LEFT>
autocmd FileType erb,eruby imap <# <%<LEFT>#<RIGHT>
autocmd FileType erb,eruby imap <= <%<LEFT>=<RIGHT>
autocmd FileType erb,eruby imap <T <#TODO

"if block
autocmd FileType erb,php vmap <silent> i
			\ :<C-U>'<put! ='<% if  %>'<CR>
			\:'>put ='<% end %>'<CR>
			\:'<-1<CR>==
			\:'>+1<CR>==
			\gv>
			\:'<-1<CR>fflli






"""""""" QH

autocmd BufReadPost *.replay    set tabstop=15 nolist

set makeprg=~/scripts/make.sh






