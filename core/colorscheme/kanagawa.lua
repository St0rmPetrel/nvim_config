local opt = vim.opt

opt.background = "dark"

local status, _ = pcall(vim.cmd, "colorscheme kanagawa")
if not status then
	print("color sheme kanagawa not found")
	return
end
