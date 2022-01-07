call plug#begin('~/.config/nvim/plugged')
Plug 'navarasu/onedark.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons' " lua
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
call plug#end()
colorscheme nightfox
lua << END
require('lualine').setup()
END
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
set number
set relativenumber
set mouse=a
