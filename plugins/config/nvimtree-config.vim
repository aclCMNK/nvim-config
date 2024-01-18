lua << EOF

-- OR setup with some options
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = false,
		--height = 15,
		side = 'right',
		centralize_selection = true,
		number = false,
		signcolumn = "yes",
		float = {
			enable = true,
			open_win_config = {
				relative = "editor",
				anchor = "NE",
				border = {"┏", "━" ,"┓", "┃", "┛", "━", "┗", "┃" },
				width = 50,
				height = 30,
				row = 100 - 1,
				col = 220 - 1,
				zindex = 3000
			}
		},
	},
	--[[diagnostics = {
        enable = true,
        show_on_dirs = true,
        debounce_delay = 50,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },]]--
	renderer = {
		highlight_opened_files = "all",
		root_folder_modifier = ":p:.",
		indent_markers = {enable = true}
	},
	filters = {
		dotfiles = true,
	}
})

EOF

