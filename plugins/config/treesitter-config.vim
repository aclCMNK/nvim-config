lua << EOF

require('nvim-treesitter.configs').setup{
  ensure_installed = { 'html', 'css', 'javascript', 'json', 'php', 'vim', 'lua', 'bash', 'gdscript', 'godot_resource', 'rust' }, -- Ensure HTML parser is installed
  highlight = {
    enable = true, -- Enable syntax highlighting
    additional_vim_regex_highlighting = true,
  },
  autotag = {
    enable = true,
    filetypes = {
      'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript', 'css', 'lua', 'xml', 'php', 'markdown', 'rust', 'rs'
    },
  },
  indent = { enable = true },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

-- For HAXE
--[[parser_config.haxe = {
  install_info = {
    url = "https://github.com/vantreeseba/tree-sitter-haxe",
    files = {"src/parser.c"},
    -- optional entries:
    branch = "main", 
  },
  filetype = "haxe",
}--]]

EOF
