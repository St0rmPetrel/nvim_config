local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { "ellisonleao/gruvbox.nvim" }

  -- windows
  use("christoomey/vim-tmux-navigator")
  use("szw/vim-maximizer")

  -- icons
  use("kyazdani42/nvim-web-devicons")
  -- status line
  use("nvim-lualine/lualine.nvim")

  -- parser
  use{
    'nvim-treesitter/nvim-treesitter',
    cmd = 'TSUpdate'
  }

  -- telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

