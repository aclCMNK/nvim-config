if has('termguicolors')
    set termguicolors
endif

let g:tokyodark_transparent_background = 0
let g:tokyodark_enable_italic_comment = 1
let g:tokyodark_enable_italic = 1
let g:tokyodark_color_gamma = "1.0"

let g:falcon_airline = 1
let g:airline_theme = 'falcon'

"Monokai styles: default, andromeda, atlantis, maia, espresso
let g:sonokai_style = 'shusia'
let g:sonokai_better_performance = 1

set background=dark
let g:everforest_background = 'hard'
let g:everforest_better_performance = 1


"-- Lsp-Colors config
lua << EOF

-- Lua
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})

EOF

"-- Colorizer config
lua << EOF

require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          })
-- Attaches to every FileType mode
require 'colorizer'.setup()

-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
require 'colorizer'.setup {
  'css';
  'javascript';
  html = {
    mode = 'foreground';
  }
}

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require 'colorizer'.setup({
  'css';
  'javascript';
  html = { mode = 'background' };
}, { mode = 'foreground' })

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require 'colorizer'.setup {
  '*'; -- Highlight all files, but customize some others.
  css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  html = { names = false; } -- Disable parsing "names" like Blue or Gray
}

-- Exclude some filetypes from highlighting by using `!`
require 'colorizer'.setup {
  '*'; -- Highlight all files, but customize some others.
  '!vim'; -- Exclude vim from highlighting.
  -- Exclusion Only makes sense if '*' is specified!
}

EOF

lua << EOF

vim.opt.background = "dark" -- set this to dark or light
vim.g.material_style = "deep ocean"

vim.g.calvera_italic_comments = true
vim.g.calvera_italic_keywords = true
vim.g.calvera_italic_functions = true
vim.g.calvera_italic_variables = false
vim.g.calvera_contrast = true
vim.g.calvera_borders = false
vim.g.calvera_disable_background = false
vim.g.transparent_bg = true

EOF

lua << EOF

require('rose-pine').setup({
	--- @usage 'auto'|'main'|'moon'|'dawn'
	variant = 'auto',
	--- @usage 'main'|'moon'|'dawn'
	dark_variant = 'main',
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = false,
	disable_float_background = false,
	disable_italics = false,

	--- @usage string hex value or named color from rosepinetheme.com/palette
	groups = {
		background = 'base',
		background_nc = '_experimental_nc',
		panel = 'surface',
		panel_nc = 'base',
		border = 'highlight_med',
		comment = 'muted',
		link = 'iris',
		punctuation = 'subtle',

		error = 'love',
		hint = 'iris',
		info = 'foam',
		warn = 'gold',

		headings = {
			h1 = 'iris',
			h2 = 'foam',
			h3 = 'rose',
			h4 = 'gold',
			h5 = 'pine',
			h6 = 'foam',
		}
		-- or set all headings at once
		-- headings = 'subtle'
	},

	-- Change specific vim highlight groups
	-- https://github.com/rose-pine/neovim/wiki/Recipes
	highlight_groups = {
		ColorColumn = { bg = 'rose' },

		-- Blend colours against the "base" background
		CursorLine = { bg = 'foam', blend = 10 },
		StatusLine = { fg = 'love', bg = 'love', blend = 10 },
	}
})


EOF

"-- Colorschemes switcher: Themery config
lua << EOF

local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local sorters = require 'telescope.sorters'
local themes = require 'telescope.themes'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local colorschemes_buffer = vim.fn.getcompletion('', 'color')

local current_scheme = vim.g.colors_name

function cspicker_reset(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local cmd = 'colorscheme ' .. current_scheme
	vim.cmd(cmd)
	actions.close(prompt_bufnr)
end

function cspicker_enter(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local cmd = 'colorscheme ' .. selected[1]
	local init = vim.fn.expand('$HOME/.config/nvim/setup/colorscheme.vim')
	vim.fn.jobstart('echo '..cmd..' > '..init)
	actions.close(prompt_bufnr)
end

function cspicker_next(prompt_bufnr)
	actions.move_selection_next(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local cmd = 'colorscheme ' .. selected[1]
	vim.cmd(cmd)
end

function cspicker_prev(prompt_bufnr)
	actions.move_selection_previous(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local cmd = 'colorscheme ' .. selected[1]
	vim.cmd(cmd)
end

local style = {
	layout_strategy = "vertical",
	layout_config = {
		height = 10,
		width = 0.3,
		prompt_position = "top"
	},
	sorting_strategy = "ascending",
}

local options = {
	finder = finders.new_table(colorschemes_buffer),
	sorter = sorters.get_generic_fuzzy_sorter({}),
	attach_mappings = function(prompt_bufnr, map)
		map('i', '<CR>', cspicker_enter)
		map('i', '<UP>', cspicker_prev)
		map('i', '<DOWN>', cspicker_next)
		map('i', '<ESC>', cspicker_reset)

		map('n', '<CR>', cspicker_enter)
		map('n', '<UP>', cspicker_prev)
		map('n', '<DOWN>', cspicker_next)
		map('n', '<ESC>', cspicker_reset)
		return true
	end
}

function ColorSchemePicker()
    local dropdown = themes.get_dropdown(style)
    local colors = pickers.new(dropdown, options)
    colors:find()
    --vim.cmd('colorscheme'..colorschemes_buffer[1])
end

EOF

