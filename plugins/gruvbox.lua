local status, gb = pcall(require, "gruvbox")
if not status then
	return
end

gb.setup({
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = false,
		operators = false,
		comments = false,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = true,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "hard", -- can be "hard", "soft" or empty string
	palette_overrides = {},
	overrides = {},
	dim_inactive = false,
	transparent_mode = false,
})
