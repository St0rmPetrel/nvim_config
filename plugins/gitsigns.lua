local status, gitsigns = pcall(require, "gitsigns")
if not status then
	print("gitsigns not found")
	return
end

-- Gitsigns
-- See `:help gitsigns.txt`
gitsigns.setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})
