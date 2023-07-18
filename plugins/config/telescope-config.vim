lua << EOF

-- You don't need to set any of these options.
-- IMPORTANT!: this is only a showcase of how you can set default options!
local fb_actions = require "telescope._extensions.file_browser.actions"
--https://github.com/nvim-telescope/telescope-file-browser.nvim
require("telescope").setup {
	extensions = {
		--https://github.com/nvim-telescope/telescope-file-browser.nvim
		file_browser = {
		  -- path
		  -- cwd
		  cwd_to_path = false,
		  grouped = false,
		  files = true,
		  add_dirs = true,
		  depth = 1,
		  auto_depth = false,
		  select_buffer = false,
		  hidden = { file_browser = false, folder_browser = false },
		  -- respect_gitignore
		  -- browse_files
		  -- browse_folders
		  hide_parent_dir = false,
		  collapse_dirs = false,
		  prompt_path = false,
		  quiet = false,
		  dir_icon = "",
		  dir_icon_hl = "Default",
		  display_stat = { date = true, size = true, mode = true },
		  hijack_netrw = false,
		  use_fd = true,
		  git_status = true,
		  mappings = {
			["i"] = {
			  ["<A-c>"] = fb_actions.create,
			  ["<S-CR>"] = fb_actions.create_from_prompt,
			  ["<A-r>"] = fb_actions.rename,
			  ["<A-m>"] = fb_actions.move,
			  ["<A-y>"] = fb_actions.copy,
			  ["<A-d>"] = fb_actions.remove,
			  ["<C-o>"] = fb_actions.open,
			  ["<C-g>"] = fb_actions.goto_parent_dir,
			  ["<C-e>"] = fb_actions.goto_home_dir,
			  ["<C-w>"] = fb_actions.goto_cwd,
			  ["<C-t>"] = fb_actions.change_cwd,
			  ["<C-f>"] = fb_actions.toggle_browser,
			  ["<C-h>"] = fb_actions.toggle_hidden,
			  ["<C-s>"] = fb_actions.toggle_all,
			  ["<bs>"] = fb_actions.backspace,
			},
			["n"] = {
			  ["c"] = fb_actions.create,
			  ["r"] = fb_actions.rename,
			  ["m"] = fb_actions.move,
			  ["y"] = fb_actions.copy,
			  ["d"] = fb_actions.remove,
			  ["o"] = fb_actions.open,
			  ["g"] = fb_actions.goto_parent_dir,
			  ["e"] = fb_actions.goto_home_dir,
			  ["w"] = fb_actions.goto_cwd,
			  ["t"] = fb_actions.change_cwd,
			  ["f"] = fb_actions.toggle_browser,
			  ["h"] = fb_actions.toggle_hidden,
			  ["s"] = fb_actions.toggle_all,
			},
		},
		coc = {
			theme = 'ivy',
			prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
		}
    },
    --https://github.com/nvim-telescope/telescope-project.nvim
    project = {
      base_dirs = {
        '~/Projs',
        '~/Comunike',
      },
      hidden_files = true, -- default: false
      theme = "dropdown",
      order_by = "asc",
      search_by = "title",
      sync_with_nvim_tree = true, -- default false
      -- default for on_project_selected = find project files
      on_project_selected = function(prompt_bufnr)
        -- Do anything you want in here. For example:
        project_actions.change_working_directory(prompt_bufnr, false)
        require("harpoon.ui").nav_file(1)
      end
    }
  },
}
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"
require'telescope'.load_extension('project')
require('telescope').load_extension('coc')

EOF

nnoremap <leader>fb :Telescope file_browser path=%:p:h select_buffer=true<CR>
nnoremap <leader>fp :Telescope project path=%:p:h select_buffer=true<CR>

"inoremap <C-A-l> <ESC>:Telescope buffers<CR>
"nnoremap <C-A-l> <ESC>:Telescope buffers<CR>

inoremap <C-A-f> <ESC>:Telescope find_files<CR>
nnoremap <C-A-f> <ESC>:Telescope find_files<CR>

inoremap <C-A-g> <ESC>:Telescope grep_string<CR>
nnoremap <C-A-g> <ESC>:Telescope grep_string<CR>



