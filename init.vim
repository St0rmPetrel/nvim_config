call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-tmux-navigator'

Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'

" completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update


call plug#end()

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Setup lspconfig.
  local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require'lspconfig'.gopls.setup {
    capabilities = capabilities
  }

  local saga = require 'lspsaga'
--  saga.init_lsp_saga()
  saga.init_lsp_saga {
    error_sign = '💥',
    warn_sign = '⚠️',
    hint_sign = '💡',
    infor_sign = 'ℹ️',
    border_style = "round",
  }
EOF

lua << EOF

--require'lspconfig'.gopls.setup{}

EOF

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

set noerrorbells
set tabstop=4
set shiftwidth=4
set colorcolumn=80

" Set relation numerotion of strings
set rnu

" Set gruvbox colorscheme
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_invert_tabline=1
let g:gruvbox_italicize_strings=1
let g:gruvbox_italic=1
let g:airline_theme = 'gruvbox'
colorscheme gruvbox
set background=dark
"set termguicolors
hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red

" Make beauty tabs
set list
set listchars=tab:>-,trail:-

" >>> Easier split navigation >>>
let g:tmux_navigator_no_mappings = 1

" Left-Mapping
nnoremap <silent> <C-H> :TmuxNavigateLeft<cr>
" Down-Mapping
nnoremap <silent> <C-J> :TmuxNavigateDown<cr>
" Up-Mapping
nnoremap <silent> <C-K> :TmuxNavigateUp<cr>
" Right-Mapping
nnoremap <silent> <C-L> :TmuxNavigateRight<cr>
" Previous-Mapping
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" <<< <<<

" Yank in clipboard
set clipboard+=unnamedplus

" Set telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
