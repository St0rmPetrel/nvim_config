-- Plugins

-- plugins install
require("nvim_config.plugins-setup")

require("nvim_config.plugins.gruvbox")
require("nvim_config.plugins.gitsigns")
require("nvim_config.plugins.lualine")
require("nvim_config.plugins.treesitter")
require("nvim_config.plugins.telescope")
require("nvim_config.plugins.nvim-cmp")
-- lsp
require("nvim_config.plugins.lsp.lspconfig")
require("nvim_config.plugins.lsp.mason")
require("nvim_config.plugins.lsp.null-ls")
require("nvim_config.plugins.lsp.lspsaga")

-- Basic options
require("nvim_config.core.options")
require("nvim_config.core.keymaps")
require("nvim_config.core.colorsheme")
