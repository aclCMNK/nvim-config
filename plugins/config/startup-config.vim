lua << EOF

function show_dashboard(redraw)
	local dashboard = require("startup")
	dashboard.setup({theme = "evil"}) -- put theme name here
	if redraw == 1 then
		dashboard.commands('display')
		--[[dashboard.display(true)
        vim.defer_fn(function()
            dashboard.redraw()
        end, 2)]]--
	end
end

show_dashboard(0)

EOF

