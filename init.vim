" general settings
set number
set relativenumber
set mouse=a
set encoding=utf-8
set autoindent
set hlsearch
set cmdheight=1
set title
set showcmd
set nobackup
set expandtab
set shiftwidth=2


call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-lua/plenary.nvim' "lua helper functions



"theming
"Plug 'navarasu/onedark.nvim'  "onedark colorscheme from atom
Plug 'EdenEast/nightfox.nvim' "nightfox colorscheme, 
Plug 'nvim-lualine/lualine.nvim' "install lualine. Not because it's special, but because nightfox supports it.

"lsp plugins

"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'neomake/neomake'

"snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'



"quality of life improvements
Plug 'nvim-telescope/telescope.nvim' "fuzzy finding at it's best
Plug 'kyazdani42/nvim-web-devicons' "pretty icons
Plug 'folke/which-key.nvim'
Plug 'sbdchd/neoformat'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'yamatsum/nvim-cursorline'
Plug 'sakhnik/nvim-gdb'
Plug 'folke/todo-comments.nvim'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'tpope/vim-eunuch'
"optional:
"Plug 'kyazdani42/nvim-tree.lua'

call plug#end()
colorscheme nightfox
"setup lua plugins
lua << END
require('lualine').setup()
--comment the following to disable clangd for lsp
require'lspconfig'.clangd.setup{}
--see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for more configuration options

require("which-key").setup {}
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    --treesitter-supported languages 
    "cpp",
  },
}
require("indent_blankline").setup {}
require("todo-comments").setup {}


END

"set the <leader> to the space-key
let mapleader =" "

"put custom commands HERE
command! run


"put keybindings HERE
""keymappings from https://github.com/nvim-telescope/telescope.nvim#default-mappings
nnoremap <leader>bf <cmd>Neoformat<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fd <cmd>Telescope diagnostics<cr>
nnoremap <leader>ec <cmd>edit ~/.config/nvim<cr>
nnoremap <leader>nh <cmd>nohl<cr>

nnoremap <leader>y "+y
nnoremap <leader>p "+pa
nnoremap <leader>d "+d

vnoremap <leader>y "+y
vnoremap <leader>p "+pa
vnoremap <leader>d "+d



"cmp setup:
"taken from https://github.com/hrsh7th/nvim-cmp
"
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
EOF

"
