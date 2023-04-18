vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>sx", ":close<CR>")

-- plugin keymaps

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- telescope
local status, builtin = pcall(require, "telescope.builtin")
if status then
	keymap.set("n", "<leader>ff", builtin.find_files, {})
	keymap.set("n", "<leader>fg", builtin.live_grep, {})
	keymap.set("n", "<leader>fb", builtin.buffers, {})
	keymap.set("n", "<leader>fh", builtin.help_tags, {})
end

-- my command
keymap.set("n", "<leader>sql", ":ExecClickSQL<CR>")
