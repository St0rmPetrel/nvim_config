local function create_command(query, host, tmp_file)
	local env
	if string.find(host, "prod") ~= nil then
		local user = os.getenv("CLICK_PROD_USER")
		if user == nil then
			error("click prod user is unset")
		end
		local password = os.getenv("CLICK_PROD_PASSWORD")
		if password == nil then
			error("click prod password is unset")
		end
		env = "clickhouse client --user " .. user .. " --password " .. password .. " --host "
	else
		local user = os.getenv("CLICK_STG_USER")
		if user == nil then
			error("click stg user is unset")
		end
		local password = os.getenv("CLICK_STG_PASSWORD")
		if password == nil then
			error("click prod password is unset")
		end
		env = "clickhouse client --user " .. user .. " --password " .. password .. " --host "
	end

	return string.format("%s %s -q %s > %s 2>&1", env, host, vim.fn.shellescape(query), tmp_file)
end

local function execClickSQL(host)
	local query = vim.fn.getreg('"')

	local tmpfile = os.tmpname()

	local success, command = pcall(create_command, query, host, tmpfile)
	if not success then
		print("Error: Unable to create a command:" .. command)
		return
	end

	local exit_code = os.execute(command)
	if not exit_code then
		print("Error: Unable to exec the command: " .. exit_code)
		return
	end

	local file = io.open(tmpfile, "r")
	if file == nil then
		print("Error: Fail to open tmpfile")
		return
	end

	local result = file:read("*all")
	file:close()
	os.remove(tmpfile)

	return result
end

function ExecClickSQL()
	local split_status, Split = pcall(require, "nui.split")
	if not split_status then
		print("nui.split plugin not found")
		return
	end
	local event_status, Autocmd = pcall(require, "nui.utils.autocmd")
	if not event_status then
		print("nui.utils.autocmd plugin not found")
		return
	end
	local menu_status, Menu = pcall(require, "nui.menu")
	if not menu_status then
		print("nui.menu plugin not found")
		return
	end

	local split = Split({
		relative = "editor",
		position = "bottom",
		size = "40%",
	})

	local menu = Menu({
		position = "50%",
		size = {
			width = 38,
			height = 12,
		},
		border = {
			style = "single",
			text = {
				top = "[Choose-Click-Host]",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = {
			Menu.item("stgch-sc-analytics-stg-1-z501.h.o3.ru"),
			Menu.item("stgch-sc-analytics-stg-2-z501.h.o3.ru"),
			Menu.item("stgch-sc-analytics-stg-3-z501.h.o3.ru"),

			Menu.item("prodch-sc-analytics-1-z501.h.o3.ru"),
			Menu.item("prodch-sc-analytics-2-z501.h.o3.ru"),
			Menu.item("prodch-sc-analytics-3-z501.h.o3.ru"),

			Menu.item("prodch-sc-analytics-1-z502.h.o3.ru"),
			Menu.item("prodch-sc-analytics-2-z502.h.o3.ru"),
			Menu.item("prodch-sc-analytics-3-z502.h.o3.ru"),

			Menu.item("prodch-sc-analytics-1-z503.h.o3.ru"),
			Menu.item("prodch-sc-analytics-2-z503.h.o3.ru"),
			Menu.item("prodch-sc-analytics-3-z503.h.o3.ru"),

			Menu.item("prodch-scenter-analytics-1-z501.h.o3.ru"),
			Menu.item("prodch-scenter-analytics-2-z501.h.o3.ru"),
			Menu.item("prodch-scenter-analytics-3-z501.h.o3.ru"),

			Menu.item("prodch-scenter-analytics-1-z502.h.o3.ru"),
			Menu.item("prodch-scenter-analytics-2-z502.h.o3.ru"),
			Menu.item("prodch-scenter-analytics-3-z502.h.o3.ru"),

			Menu.item("prodch-scenter-analytics-1-z503.h.o3.ru"),
			Menu.item("prodch-scenter-analytics-2-z503.h.o3.ru"),
			Menu.item("prodch-scenter-analytics-3-z503.h.o3.ru"),
		},
		max_width = 20,
		keymap = {
			focus_next = { "j" },
			focus_prev = { "k" },
			close = { "<Esc>" },
			submit = { "<CR>" },
		},
		on_close = function()
			print("Menu Closed!")
		end,
		on_submit = function(item)
			split:mount()
			split:on(Autocmd.event.BufLeave, function()
				split:unmount()
			end)

			local result = execClickSQL(item.text)
			vim.api.nvim_buf_set_lines(split.bufnr, 0, -1, true, vim.split(result, "\n"))
		end,
	})

	-- mount the component
	menu:mount()
end

vim.api.nvim_create_user_command("ExecClickSQL", function()
	ExecClickSQL()
end, {})
