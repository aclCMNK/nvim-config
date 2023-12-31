lua << EOF

local fp = require('fold-preview')
local map = require('fold-preview').mapping
local keymap = vim.keymap
fp.setup({
	border= "single",
	default_keybindings = false
})

keymap.amend = require('keymap-amend')
keymap.amend('n', 'K', function(original)
	if not fp.show_preview() then original() end
 -- or
 -- if not fp.toggle_preview() then original() end
 -- to close preview on second press on K.
end)
keymap.amend('n', 'h',  map.close_preview_open_fold)
keymap.amend('n', 'l',  map.close_preview_open_fold)
keymap.amend('n', 'zo', map.close_preview)
keymap.amend('n', 'zO', map.close_preview)
keymap.amend('n', 'zc', map.close_preview_without_defer)
keymap.amend('n', 'zR', map.close_preview)
keymap.amend('n', 'zM', map.close_preview_without_defer)

EOF
