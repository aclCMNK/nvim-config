lua << EOF

require('nvim-treesitter.configs').setup{
  ensure_installed = { 'html', 'css', 'javascript', 'json', 'php', 'vim', 'lua', 'bash', 'gdscript', 'godot_resource' }, -- Ensure HTML parser is installed
  highlight = {
    enable = true, -- Enable syntax highlighting
    additional_vim_regex_highlighting = true,
  },
  autotag = {
    enable = true,
    filetypes = {
      'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript', 'css', 'lua', 'xml', 'php', 'markdown'
    },
  },
  indent = { enable = true },
}

EOF
