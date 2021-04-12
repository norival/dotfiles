" neovim configuration file based on sample vimrc
" Xavier Laviron
set nocompatible

" PLUGINS START ----------------------------------------------------------------
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" --> General plugins
Plug '907th/vim-auto-save'          " auto save
Plug 'airblade/vim-gitgutter'       " git signs
Plug 'chrisbra/CheckAttach'         " check attachments in mails
" Plug 'dense-analysis/ale'           " async linting engine
Plug 'habamax/vim-gruvbit'          " GruvBit colorscheme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'             " fzf integration
Plug 'junegunn/vim-easy-align'      " easy custom alignments
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " completion
" Plug 'neoclide/jsonc.vim'
Plug 'psliwka/vim-smoothie'         " smooth scrolling with <C-d> etc
Plug 'tpope/vim-commentary'         " easy comments
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-fugitive'           " git integration
Plug 'tpope/vim-obsession'          " automatic sessions handling
Plug 'tpope/vim-surround'           " change tags
Plug 'tpope/vim-vinegar'            " better netrw

Plug 'taniarascia/new-moon.vim'
Plug 'sheerun/vim-polyglot'
Plug 'sainnhe/everforest'
Plug 'sainnhe/gruvbox-material'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

" --> Language specifics plugins
Plug 'brett-griffin/phpdocblocks.vim'
Plug 'chr4/nginx.vim'               " nginx syntax
Plug 'dbeniamine/todo.txt-vim'      " todotxt support
Plug 'jalvesaq/Nvim-R'              " R support
Plug 'lervag/vimtex'                " LaTeX support
" Plug 'mboughaba/i3config.vim'       " i3 config syntax
" Plug 'tmux-plugins/vim-tmux'        " tmux syntax
" Plug 'cespare/vim-toml'             " toml support

" --> Plugins for web development
" Plug 'alvan/vim-closetag'
Plug 'captbaritone/better-indent-support-for-php-with-html'
" Plug 'lumiliet/vim-twig'            " twig syntax
" Plug 'nelsyeung/twig.vim'
Plug 'mattn/emmet-vim'              " support for emmet abbreviations
" Plug 'othree/html5.vim'             " html suppport
" Plug 'pangloss/vim-javascript'      " javascript support
Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o', 'branch': 'master'}
Plug 'tpope/vim-surround'           " edtit surroundings
" Plug 'StanAngeloff/php.vim'         " php support
Plug 'vim-scripts/loremipsum'       " insert lorem text
" Plug 'cakebaker/scss-syntax.vim'
Plug 'heavenshell/vim-jsdoc', {'tag': '1.0.0'}

Plug 'doums/darcula'
Plug 'bratpeki/truedark-vim'
Plug 'kyazdani42/blue-moon'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }

Plug 'fenetikm/falcon'

" --> Other plugins
" Plug 'rhysd/vim-grammarous'           " check grammar
" Plug 'dpelle/vim-LanguageTool'        " spelling tool


" Initialize plugin system
call plug#end()

" PLUGINS END ------------------------------------------------------------------

set mouse=r

" support for language tools
" let g:languagetool_jar='/home/xavier/.local/share/nvim/plugged/vim-grammarous/misc/LanguageTool-4.5/languagetool-commandline.jar'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup      " no backup files kept
set nowritebackup
set history=100	  " keep 50 lines of command line history
set ruler		  " show the cursor position all the time
set showcmd		  " display incomplete commands
set incsearch     " do incremental searching
set nu            " show line numbers
set textwidth=80
set linebreak     " break long lines

" Foldings
set foldmethod=syntax
set foldnestmax=1

" Set tabulations
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set showmode

" allow hidden buffers
set hidden

" persistent undo history
set undodir=~/.local/share/nvim/undo

" do not add two spaces between sentences when autoformatting
set nojoinspaces

" do not fold
set nofoldenable

"" Colors
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
set hlsearch

if (has('termguicolors'))
    set termguicolors
endif

" colorscheme
" colorscheme gruvbit
" colorscheme new-moon
" colorscheme darcula
" colorscheme truedark
" colorscheme blue-moon
" set background=light
" let g:everforest_background = 'hard'
" colorscheme everforest
" colorscheme spaceduck
"
let g:gruvbox_material_palette = 'original'
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material
"
" let g:material_theme_style = 'darker'
" colorscheme material
" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'

" colorscheme falcon

" highlight current line
set cursorline

" always show the gutter
set signcolumn=yes

" Autogenerate tags from files in ~/.vim/doc/
" autocmd BufWritePost ~/.config/nvim/doc/* :helptags ~/.config/nvim/doc

" autosave
" autocmd TextChanged,TextChangedI * silent write

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fill rest of line with characters
function! FillLine(str)
    " set tw to the desired total length
    let tw = &textwidth
    if tw==0 | let tw = 80 | endif
    " strip trailing spaces first
    .s/[[:space:]]*$//
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(a:str)
    " insert them, if there's room, removing trailing spaces (though forcing
    " there to be one)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
endfunction

" function! LinterStatus() abort
"     let l:counts = ale#statusline#Count(bufnr(''))

"     let l:all_errors = l:counts.error + l:counts.style_error
"     let l:all_non_errors = l:counts.total - l:all_errors

"     return l:counts.total == 0 ? 'OK' : printf(
"     \   '%dW %dE',
"     \   all_non_errors,
"     \   all_errors
"     \)
" endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = '!'
let maplocalleader = ","

set timeout ttimeoutlen=50
imap jk <Esc>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
map S :Gstatus<CR>

" maps non breaking space into normal space
imap   <space>

tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <A-q> <C-\><C-n>
tnoremap <C-j><C-k> <C-\><C-n>

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <A-o> <C-w>gf
nnoremap <A-n> :bnext<CR>
nnoremap <A-p> :bprevious<CR>
nnoremap <A-Tab> :e #<CR>
nnoremap <A-z> <C-w>_

nmap <F12> :call FillLine('*')<CR>
imap <F12> <C-o>:call FillLine('*')<CR>jk
nmap <F11> :call FillLine('-')<CR>
imap <F11> <C-o>:call FillLine('-')<CR>jk

map <A-b> :ls<CR>:buffer 
map <A-B> :ls<CR>:bdelete

" find TODO comments in files
nmap <Leader>pt :vimgrep /TODO/ src/**/*.php<CR>:copen<CR>
nmap <Leader>jt :vimgrep /TODO/ assets/**/*.js<CR>:copen<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" format hunks summary for statusline (from gitgutter doc)
function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
endfunction

" Custom status line
set statusline=
set statusline+=\ \[%n\]\ 
set statusline+=%{FugitiveStatusline()}
set statusline+=\[%{GitStatus()}\]
" set statusline+=\[%{LinterStatus()}\]
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=\ %f%m%r%h
set statusline+=%=
set statusline+=(%l\|%c)
set statusline+=%y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=%{ObsessionStatus()}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tex_flavor='latex'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stuff for editing gpg files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't save backups of *.gpg files
set backupskip+=*.gpg
" To avoid that parts of the file is saved to .viminfo when yanking or
" deleting, empty the 'viminfo' option.
set viminfo=

augroup encrypted
    au!
    " Disable swap files, and set binary file format before reading the file
    autocmd BufReadPre,FileReadPre *.gpg
                \ setlocal noswapfile bin
    " Decrypt the contents after reading the file, reset binary file format
    " and run any BufReadPost autocmds matching the file name without the .gpg
    " extension
    autocmd BufReadPost,FileReadPost *.gpg
                \ execute "'[,']!gpg --decrypt --default-recipient-self" |
                \ setlocal nobin |
                \ execute "doautocmd BufReadPost " . expand("%:r")
    " Set binary file format and encrypt the contents before writing the file
    autocmd BufWritePre,FileWritePre *.gpg
                \ setlocal bin |
                \ '[,']!gpg --encrypt --default-recipient-self
    " After writing the file, do an :undo to revert the encryption in the
    " buffer, and reset binary file format
    autocmd BufWritePost,FileWritePost *.gpg
                \ silent u |
                \ setlocal nobin
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GitGutter settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <A-v> :GitGutterPreviewHunk<CR>
nmap <A-;> :GitGutterPrevHunk<CR>
nmap <A-,> :GitGutterNextHunk<CR>
nmap <A-u> :GitGutterUndoHunk<CR>
nmap <A-S> :GitGutterStageHunk<CR>

" show signs faster
set updatetime=100

" colors
highlight link GitGutterDelete jsFuncArgs
highlight link GitGutterAdd DiffAdded
highlight link GitGutterChangeLine DiffChange
highlight clear SignColumn

" keyword for attachments detection in mails
let g:attach_check_keywords = ',joinds,join,ci-joint,jointe'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Use todo#Complete as the omni complete function for todo files
au filetype todo setlocal omnifunc=todo#Complete

" auto prefix current date to new tasks
let g:Todo_txt_prefix_creation_date=1

" auto save settings
" let g:auto_save = 0        " enable AutoSave on Vim startup
" let g:auto_save_silent = 1 " do not display the auto-save notification
" let g:auto_save_events = ["CursorHold"]

" disable autosave for mail files
augroup ft_mail
    au!
    au FileType mail let b:auto_save = 0
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Config for development plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" emmet leader key
let g:user_emmet_leader_key = '<C-j>'

" linting only on save
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 1

" phpactor php completion
autocmd FileType php setlocal omnifunc=phpactor#Complete
" autocmd FileType php set iskeyword+=$

" syntax for jsdoc blocks
let g:javascript_plugin_jsdoc = 1

" do not lint js with ale
" let g:ale_linters = {'javascript': ['eslint'], 'php': ['php', 'phpstan', 'phpcs']}
" let g:ale_linters = {'javascript': ['eslint'], 'php': ['php', 'phpcs']}

" let g:ale_php_phpstan_executable = '/home/xavier/.config/composer/vendor/bin/phpstan'
" let g:ale_php_phpstan_level = 3

" let g:ale_php_phpcs_executable = '/home/xavier/.config/composer/vendor/bin/phpcs'
" let g:ale_php_phpcs_standard = 'PSR12'

" let g:ale_fixers = {'javascript': ['prettier'], 'css': ['prettier']}
" let g:ale_fixers = {'javascript': ['prettier'], 'css': ['prettier']}
" let g:ale_linters_explicit = 1

" let g:ale_fixers = {'php': ['php_cs_fixer']}
" let g:ale_php_cs_fixer_executable = '/home/xavier/.config/composer/vendor/bin/php-cs-fixer'
" let g:ale_php_cs_fixer_options = '--rules=no_unused_imports,@PSR2'
" let g:ale_php_cs_fixer_options = '--rules=@PSR12,no_unused_imports,@Symfony,{"binary_operator_spaces": {default: "align"}}'
" let g:ale_fix_on_save = 0

let g:AutoPairsCenterLine = 0

" FZF settings
nnoremap <silent> <C-f> :GFiles<CR>
nnoremap <silent> <C-g> :Files<CR>
nnoremap <silent> <C-z> :Ag<CR>

" CoC configuration ************************************************************

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

nmap <leader>ac  <Plug>(coc-codeaction)
