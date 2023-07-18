lua << EOF

require('telescope').load_extension("workspaces")
require("telescope").setup({
  extensions = {
    workspaces = {
      -- keep insert mode after selection in the picker, default is false
      keep_insert = true,
    }
  },
    hooks = {
        open = { "NvimTreeOpen", "Telescope find_files" },
    }
})
require("workspaces").setup(
    {
        -- path to a file to store workspaces data in
        -- on a unix system this would be ~/.local/share/nvim/workspaces
        path = vim.fn.stdpath("data") .. "/workspaces",
        -- to change directory for nvim (:cd), or only for window (:lcd)
        -- deprecated, use cd_type instead
        -- global_cd = true,
        -- controls how the directory is changed. valid options are "global", "local", and "tab"
        --   "global" changes directory for the neovim process. same as the :cd command
        --   "local" changes directory for the current window. same as the :lcd command
        --   "tab" changes directory for the current tab. same as the :tcd command
        --
        -- if set, overrides the value of global_cd
        cd_type = "global",
        -- sort the list of workspaces by name after loading from the workspaces path.
        sort = true,
        -- sort by recent use rather than by name. requires sort to be true
        mru_sort = true,
        -- option to automatically activate workspace when opening neovim in a workspace directory
        auto_open = false,
        -- enable info-level notifications after adding or removing a workspace
        notify_info = true,
        hooks = {
            open = { "NvimTreeOpen" }
        }
    }
)

EOF

command! Projects :Telescope workspaces
