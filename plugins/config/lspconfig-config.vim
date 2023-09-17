lua << EOF

-- Servers list
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lspconfig = require('lspconfig')
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local rust_tools = require("rust-tools")
mason.setup()
mason_lspconfig.setup()
--local breadcrumb = require("breadcrumb")
local navbuddy = require("nvim-navbuddy")
local navic = require("nvim-navic")

-- Configure tsserver as the LSP for JavaScript and TypeScript
lspconfig.tsserver.setup{
    cmd = {"typescript-language-server", "--stdio"},
    filetypes = {"typescript", "typescriptreact", "javascript", "javascriptreact"},
    on_attach = function(client, bufnr)
        -- Customizations when the LSP client attaches
        -- For example, you can configure mappings or additional settings here
        -- Enable auto-formatting on save (optional)
        --vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)')
        --require("lsp-format").on_attach(client)

        -- Enable JavaScript specific diagnostics
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                underline = true,
                virtual_text = false,
                signs = true,
                update_in_insert = true,
            }
        )
		navbuddy.attach(client, bufnr)
		navic.attach(client, bufnr)
		--if client.server_capabilities.documentSymbolProvider then
			--breadcrumb.attach(client, bufnr)
		--end

        --local basics = require('lsp_basics')
        --basics.make_lsp_commands(client, bufnr)
        --basics.make_lsp_mappings(client, bufnr)
    end,
    flags = {
        debounce_text_changes = 150,
    },
    folding = {
        enable = true
    },
    indent = {
        enable = true
    },
	treesitter = {
		enable = true
	},
    --capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
        -- TypeScript-specific settings
        TypeScript = {
            -- Additional options for TypeScript LSP server
            -- For example:
            importModuleSpecifierEnding = "js",
            validate = true
        }
    }
}
-- Configure html as the LSP for HTML files
lspconfig.html.setup{
    cmd = {"html-languageserver", "--stdio"},
    filetypes = {"html"},
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true
        },
        provideFormatter = true
    },
    ensure_installed = {
        "html",
        "css",
        "javascript"
    },
    folding = {
        enable = true
    },
    indent = {
        enable = true
    },
    single_file_support = true,
    on_attach = function(client, bufnr)
        -- Attach JavaScript LSP server
        if client.name == "html" then
            require('lspconfig').tsserver.setup{ on_attach = client.on_attach }
            require('lspconfig').cssls.setup{ on_attach = client.on_attach }
        end
		navbuddy.attach(client, bufnr)
		navic.attach(client, bufnr)
        -- Customizations when the LSP client attaches
        -- For example, you can configure mappings or additional settings here
        -- Enable auto-formatting on save (optional)
    end,
    --capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    treesitter = {
        enable = true
    }
}

-- Configure cssls as the LSP for CSS files
lspconfig.cssls.setup{
    --capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnr)
		navbuddy.attach(client, bufnr)
		navic.attach(client, bufnr)
        --require("lsp-format").on_attach(client)
    end
}

lspconfig.rust_analyzer.setup{
	filetypes = { "rustup", "run", "stable", "rust-analyzer" },
	cmd = { "rust-analyzer" },
	--root_dir = root_pattern("Cargo.toml"),
	on_attach = function(client, bufnr)
		navbuddy.attach(client, bufnr)
		navic.attach(client, bufnr)
	end
}
rust_tools.setup{
	on_attach = function(client, bufnr)
		navbuddy.attach(client, bufnr)
		navic.attach(client, bufnr)
	end
}

lspconfig.vimls.setup{}
lspconfig.lua_ls.setup{}
lspconfig.csharp_ls.setup{}
lspconfig.gdscript.setup{}
lspconfig.jsonls.setup{}

lspconfig.haxe_language_server.setup{
	cmd = { "node", "/home/kamiloid/.config/haxe-language-server/bin/server.js" },
	filetypes = { "haxe" },
	init_options = {
		displayArguments = { "build.hxml" }
	},
	settings = {
		haxe = {
			executable = "haxe"
		}
	}
}

-- Autocompletion with nvim-compe
--[[
require('compe').setup{
    enabled = true,
    autocomplete = true,
    source = {
        path = true,
        buffer = true,
        nvim_lsp = true,
        nvim_lua = true,
        { name = "nvim_lsp" },
        { name = "buffer" }
    }
}


local cmp = require('cmp')
-- Configure completion-nvim
cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
    window = {
        documentation = {
            border = 'single',
            winhighlight = 'NormalFloat:NormalFloat'
        }
    },
    formatting = {
        format = require'lspkind'.cmp_format({ with_text = false, maxwidth = 50 })
    }
})
]]--

EOF


lua << EOF
--[[
require('lspkind').init({
    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    -- default: 'default'
    preset = 'codicons',
    -- override preset symbols
    -- default: {}
    symbol_map = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "",
    },
})
]]--
EOF



" Customize the completion window appearance
highlight link CompeDocumentation NormalFloat
" Set the border around the documentation window
highlight link CompeDocumentationBorder NormalFloat
augroup CompePopup
  autocmd!
  autocmd ColorScheme * highlight CompeDocumentationBorder guifg=#ffffff guibg=#61afef gui=bold
augroup END

" Set the completion popup options
set pumheight=10                   " Set the maximum height of the popup
set pumblend=5                    " Set the transparency level of the popup

" Customize the appearance of the completion popup
highlight Pmenu           guibg=#282c34 guifg=#abb2bf
highlight PmenuSel        guibg=#61afef guifg=#ffffff gui=bold
highlight PmenuSbar       guibg=#282c34
highlight PmenuThumb      guibg=#abb2bf
highlight PmenuThumbFloat guibg=#61afef

" Add a border to the completion popup
augroup CompletionPopup
  autocmd!
  autocmd ColorScheme * highlight PmenuBorder guifg=#61afef
  autocmd FileType * set completeopt+=menuone
augroup END
