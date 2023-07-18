lua << EOF

vim.diagnostic.config({
    virtual_text = true,
})
require("lsp_lines").setup()

EOF

