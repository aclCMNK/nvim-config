local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local function split(str, sep)
	local result = {}
	local regex = ("([^%s]+)"):format(sep)
	for each in str:gmatch(regex) do
		table.insert(result, each)
	end
	return result
end

function SearchInDir()
	local input = Input({
		position = "50%",
		size = {
			width = 50,
		},
		border = {
			style = "single",
			text = {
				top = "Search text in file",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		prompt = "> ",
		default_value = "",
		on_close = function()
			print("Input Closed!")
		end,
		on_submit = function(value)
			print(value)
			local split = split(value, " ")
			local num_args = table.getn(split)
			if num_args == 0 then
				print("The search must be writen: <text to search> [dir path]")
				return
			end
			local pattenr = split[1]
			local path = "./*"
			if num_args > 1 then
				path = split[2]
			end
			local grep = "vimgrep /" .. pattenr .. "/ " .. path
			local ok = pcall(vim.cmd, grep)
			if ok == false then
				print("Required text not found!")
				return
			end
			vim.cmd("copen")
			vim.cmd("let @/ = @/")
		end,
	})

	-- mount/open the component
	input:mount()

	-- unmount component when cursor leaves buffer
	input:on(event.BufLeave, function()
		input:unmount()
	end)
end

return {
	SearchInDir = SearchInDir
}
