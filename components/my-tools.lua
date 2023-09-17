local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event

local tools = {}
local lines = {}

function AddTools(Tools)
	for key, value in pairs(Tools) do
		tools[key] = value
	end
	AddTools2Lines();
end

function Add2MyTools(key, value)
	if tools[key] ~= nil then
		return
	end
	tools[key] = value
	table.insert(lines, Menu.item(value))
end

function AddSeparator(title)
	table.insert(lines, Menu.separator(title, { char = '_', text_align = "center" }))
end

function AddTools2Lines()
	for key, value in pairs(tools) do
		table.insert(lines, Menu.item(value))
	end
end

function MyTools()
	vim.cmd("NvimTreeClose")
	local menu = Menu({
		position = { col = "98%", row = "95%" },
		size = {
			width = 30,
			height = 25,
		},
		border = {
			style = "single",
			text = {
				top = "Most useful Tools",
				top_align = "right",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = lines,
		max_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_close = function()
			print("Menu Closed!")
		end,
		on_submit = function(item)
			print("Menu Submitted: ", item.text)
			for key, value in pairs(tools) do
				if value == item.text then
					vim.cmd(key)
				end
			end
		end,
	})

	-- mount the component
	menu:mount()
end

return {
	Add2MyTools = Add2MyTools,
	AddTools = AddTools,
	AddSeparator = AddSeparator
}
