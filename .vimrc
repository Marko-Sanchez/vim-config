call plug#begin()
Plug 'frazrepo/vim-rainbow'
Plug 'tpope/vim-surround'
Plug 'jacoborus/tender.vim'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
call plug#end()

" vim-rainbow****
	let g:rainbow_active = 1

" tender.vim
	" Theme
	syntax enable
	if 0
		let g:gruvbox_contrast_dark = 'hard'
		colorscheme gruvbox " alternative is tender
		let g:lightline ={'colorscheme':'gruvbox'} " part of light line plugin
		
		set background =dark    " Setting dark mode,gruvbox
	endif
   if 1
      let g:seoul256_background = 233
      let g:seoul256_srgb = 1
      colo seoul256
      let g:lightline = {'colorscheme':'seoul256'}
	endif
	if 0 
		colorscheme tender " alternative is gruvbox
		" hi Comment ctermfg=22 " Changes comment color
		let g:lightline = {'colorscheme':'tender'} " part of light line plugin
	endif

" vim-numbertoggle
	" Shows Numbers on the side and changes there color
	set number
	highlight LineNr ctermfg=grey

" Limelight 
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_default_coefficient = 0.7

" Goyo Focus
function! s:goyo_enter()
   Limelight
endfunction
function! s:goyo_leave()
   Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nmap <F12> :Goyo <CR>

" Custom mappings
	" Snippet, Loads Skeleton code
	nnoremap <Leader>c :-1read ~/.vim/file_templates/skeleton.c<CR>


" Default stuff****
" Finding Files :Find <filename>
set path+=**

"Display all matching files when we tab complete
set wildmenu

" Displays commands you are typing
set showcmd


" Shows Line Status at all times
set laststatus=2

" Configing the status line
set statusline=%f               " filename relative to current $PWD
set statusline+=%h              " help file flag
set statusline+=%m              " modified flag
set statusline+=%r              " readonly flag
set statusline+=\ [%{&ff}]      " Fileformat [unix]/[dos] etc...
set statusline+=\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})  " last modified t    imestamp
set statusline+=%=              " Rest: right align
set statusline+=%l,%c%V         " Position in buffer: linenumber, column, virtual column
set statusline+=\ %P            " Position in buffer: Percentage

set ai                          " set auto indeting for programming
set showmatch                   " automatically show matching brackets
set showmode                    " show the current mode
set wildmode=list:longest,longest:full " better command line completion

" Tab stuff
set tabstop=3
set shiftwidth=3
set softtabstop=3
set expandtab
set smarttab
set list
set listchars=tab:\\·,trail:·

autocmd FileType make setlocal noexpandtab

"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,MERGE_MSG,git-rebase-todo setlocal fileencodings=utf-8
    " Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && &filetype !~# 'commit\|gitrebase'
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff" |
      \   exe "normal g`\"" |
      \ endif

       autocmd BufNewFile,BufRead *.patch set filetype=diff

       autocmd Filetype diff
       \ highlight WhiteSpaceEOL ctermbg=red |
       \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/
endif " has("autocmd")

