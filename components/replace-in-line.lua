local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

function ReplaceInLine()
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
			if num_args <= 1 then
				print("The replace must be writen: <text to replace> <new text>")
				return
			end
			local text = split[1]
			local new_text = split[2]
			local case_sensitive = "i";
			if num_args == 3 then
				if split[3] == "cs" then
					case_sensitive = ""
				end
			end
			local grep = "s/" .. text .. "/" .. new_text .. "/g" .. case_sensitive
			local ok = pcall(vim.cmd, grep)
			if ok == false then
				print("Required text not found!")
				return
			end
			vim.cmd("copen")
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
	ReplaceInLine = ReplaceInLine
}
