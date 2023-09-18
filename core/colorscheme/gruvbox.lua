local opt = vim.opt

opt.background = "dark"

local status, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not status then
	print("color sheme gruvbox not found")
	return
end
