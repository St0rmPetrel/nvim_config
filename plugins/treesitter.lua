local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	print("treesitter not found")
	return
end

treesitter.setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"c",
		"lua",
		"go",
		"bash",
		"json",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		-- `false` will disable the whole extension
		enable = true,
	},
})
