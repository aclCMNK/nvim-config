function! Search(args)
	let split = split(a:args, ' ')
	if len(split) < 1
		echo "Text is required, use ':Search <text>'"
		return
	endif
	let text = split[0]  " First argument is the search text
	let case_sensitive = 'i'
	if len(split) > 1
		if split[1] == 'cs'
			execute 'set noignorecase'
		endif
	endif
	redir => output
	execute '/'.text
	redir END
	if output =~# 'E'
		echomsg 'Pattern not found.'
	endif
	execute 'normal! n'
	execute 'match Search /'.text.'/'
	execute 'let @/ = @/'
	execute 'set ignorecase'
endfunction

function! SearchAll(args)
	let split = split(a:args, ' ')
	if len(split) == 0
		echo "Pattern is required, use ':SearchAll <pattern> [extension - type of files without dot]'"
		return
	endif
	let pattern = split[0]  " First argument is the search pattern
	let extStr = ''
	if len(split) > 1
		let extStr = '.' . split[1]
	endif
	if len(split) > 2
		if split[2] == 'cs'
			execute 'set noignorecase'
		endif
	endif
	redir => output
	execute 'vimgrep /'.pattern.'/ **/*'.extStr
	redir END
	if output =~# 'E'
		echomsg 'Pattern not found.'
	else
		execute 'copen'
	endif
	execute 'set ignorecase'
endfunction

function! SearchInDirectory(args)
	let split = split(a:args, ' ')
	if len(split) == 0
		echo "Pattern is required, use ':SearchAll <pattern> <directory_path>'"
		return
	endif
	let pattern = split[0]  " First argument is the search pattern
	let extStr = ''
	if len(split) > 1
		let extStr = split[1]
	endif
	if len(split) > 2
		if split[2] == 'cs'
			execute 'set noignorecase'
		endif
	endif
	redir => output
	execute 'vimgrep /'.pattern.'/ '.extStr
	redir END
	if output =~# 'E'
		echomsg 'Pattern not found.'
	else
		execute 'copen'
	endif
	execute 'set ignorecase'
endfunction

function! ReplaceAll(args)
	let split = split(a:args, ' ')
	if len(split) < 2
		echo "Text and NewText are required, use ':ReplaceAll <text> <new_text>'"
		return
	endif
	let text = split[0]  " First argument is the search text
	let new_text = split[1]  " First argument is the search text
	let case_sensitive = 'i'
	if len(split) > 2
		if split[2] == 'cs'
			let case_sensitive = ''
		endif
	endif
	execute '%s/'.text.'/'.new_text.'/g'.case_sensitive
endfunction

function! ReplaceInLine(args)
	let split = split(a:args, ' ')
	if len(split) < 2
		echo "Text and NewText are required, use ':ReplaceInLine <text> <new_text>'"
		return
	endif
	let text = split[0]  " First argument is the search text
	let new_text = split[1]  " First argument is the search text
	let case_sensitive = 'i'
	if len(split) > 2
		if split[2] == 'cs'
			let case_sensitive = ''
		endif
	endif
	execute 's/'.text.'/'.new_text.'/g'.case_sensitive
endfunction

lua << EOF
function CloseAll()
	vim.cmd(':NvimTreeClose')
	local buffers = vim.api.nvim_list_bufs()
	for _, bufnr in pairs(buffers) do
		local modified = vim.api.nvim_buf_get_option(bufnr, 'modified')
		if modified then
			local prompt = string.format("This "..bufnr.." file is not saved, Do you want to save it?")
			local confirm = vim.fn.confirm(prompt, '&y\n&n')
			if confirm == 1 then
				vim.cmd(":w!")
			elseif confirm == 2 then
				vim.api.nvim_buf_set_option(bufnr, "modified", false)
			end
		end
		local success, err = pcall(vim.cmd, ":bdelete "..bufnr)
		if not success then
			print("Error: "..err)
			vim.cmd(":q!")
		end
	end
	vim.cmd(':q!')
end
EOF

lua << EOF
function get_visible_buffer_count()
    local buffer_handles = vim.api.nvim_list_bufs()
    local visible_buffer_count = 0
    for _, buf in ipairs(buffer_handles) do
        if vim.api.nvim_buf_get_option(buf, 'buflisted') then
            visible_buffer_count = visible_buffer_count + 1
        end
    end
    return visible_buffer_count
end
EOF

lua << EOF
function CloseBuffer()
	local bufnr = vim.api.nvim_get_current_buf()
	local modified = vim.api.nvim_buf_get_option(bufnr, 'modified')
	if modified then
		local prompt = string.format("This "..bufnr.." file is not saved, Do you want to save it?")
		local confirm = vim.fn.confirm(prompt, '&y\n&n')
		if confirm == 1 then
			vim.cmd(":w!")
		elseif confirm == 2 then
			vim.api.nvim_buf_set_option(bufnr, "modified", false)
		end
	end
	vim.cmd(':bdelete '..bufnr)
	local active_count = get_visible_buffer_count()
	local current_buffer = vim.api.nvim_get_current_buf();
	local bufname = vim.api.nvim_buf_get_name(current_buffer)
	if active_count == 1 and bufname == '' then
		vim.cmd(":NvimTreeOpen")
		--[[vim.cmd(":NvimTreeClose")
		vim.wait(200, function()
			vim.cmd(":StartupScreen")
			vim.wait(200, function()
				vim.cmd(":NvimTreeRefresh")
				vim.cmd(":NvimTreeFocus")
			end)
		end)]]--
	end
end

function PreviewFold()
	local fp = require('fold-preview')
	if not fp.toggle_preview() then original() end
end
EOF

lua << EOF

function Expand_window()
	vim.cmd('wincmd 80|')
	vim.cmd('wincmd 25_')
	vim.cmd('resize')
end

--vim.cmd([[autocmd WinEnter * lua Expand_window()]])

EOF


"GENERAL FUNCTIONS:
command! WSCloseBuffer :lua CloseBuffer()
command! WSCloseEditor :lua CloseAll()
command! -nargs=* -complete=file WSSearch call Search(<q-args>)
command! -nargs=* -complete=file WSSearchInDirectory call SearchInDirectory(<q-args>)
command! -nargs=* -complete=file WSSearchAll call SearchAll(<q-args>)
command! -nargs=* -complete=file WSReplaceAll call ReplaceAll(<q-args>)
command! -nargs=* -complete=file WSReplaceInLine call ReplaceInLine(<q-args>)

"RESIZE WINDOW:
command! Fullscreen :lua Expand_window()
command! NoFullscreen :wincmd =

"PLUGINS:
"--BUFFER MANAGER
command! WSBuffers :lua require("buffer_manager.ui").toggle_quick_menu()

"--COC
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
command! -nargs=0 DefinitionPreview :CocCommand fzf-preview.CocDefinition
command! -nargs=0 GotoDefinition :CocCommand tsserver.goToSourceDefinition

"--FTERM
command! WSTerminalOpen :lua require('FTerm').open()
command! WSTerminalClose :lua require('FTerm').close()
command! WSTerminalExit :lua require('FTerm').exit()
command! WSTerminalToggle :lua require('FTerm').toggle()
command! Lgit :lua require('FTerm').run({ 'lgit' })

"--MEMENTO
command! Memento :lua require("memento").toggle()
command! MementoClear :lua require("memento").clear_history()
command! WSFileHist :lua require("memento").toggle()
command! WSFileHistClear :lua require("memento").clear_history()

"--STARTUP
command! StartupScreen :lua show_dashboard(1)
command! WSMainScreen :lua show_dashboard(1)

"--SYMBOLS-OUTLINE
command! WSFileTree :SymbolsOutline

"--TELESCOPE
command! Projects :Telescope workspaces
command! WSProjs :Telescope workspaces

"-- NAVBUDDY
command! WSFileNav :Navbuddy

"--GOTO
command! WSPreviewDef :lua require('goto-preview').goto_preview_definition()
command! WSPreviewTypeDef :lua require('goto-preview').goto_preview_type_definition()
command! WSPreviewImplementation :lua require('goto-preview').goto_preview_implementation()
command! WSPreviewCloseAll :lua require('goto-preview').close_all_win()
command! WSPreviewReference :lua require('goto-preview').goto_preview_references()

"--COLORSCHEMES
command! WSColorSchemePicker :lua ColorSchemePicker()
command! MaterialStyles :lua require('material.functions').toggle_style()

autocmd CursorHold * silent call CocActionAsync('highlight')

command! MyTools :lua MyTools()
command! WSSearchInFile :lua SearchInFIle()
command! WSSearchInDir :lua SearchInDir()
command! WSReplaceInFile :lua ReplaceInFile()
command! WSReplaceInLineComp :lua ReplaceInLine()

command! PreviewFold :lua PreviewFold()

command! Vifm FloatermNew vifm ./ ./

lua << EOF
package.path = package.path .. ";/home/kamiloid/.config/nvim/components/?.lua"
local Mytools = require("my-tools")
local SearchInFIle = require("search-in-file")
local SearchInDir = require("search-in-dir")
local ReplaceInFile = require("replace-in-file")
local ReplaceInLineComp = require("replace-in-line")

AddSeparator("Main")
Add2MyTools("WSMainScreen", "Dashboard")
Add2MyTools("Telescope file_browser path=%:p:h select_buffer=true", "File Browser")
Add2MyTools("Telescope find_files", "Search file")
Add2MyTools("Files", "Files")
Add2MyTools("WSProjs", "Projects list")
Add2MyTools("Telescope project path=%:p:h select_buffer=true", "Folders in Projects")
Add2MyTools("Telescope grep_string", "Search text in project")

AddSeparator("Browsers")
Add2MyTools("Vifm", "Vifm")

AddSeparator("WorkSpace")
Add2MyTools("WSBuffers", "Opened files")
Add2MyTools("Telescope buffers", "Buffers")
Add2MyTools("WSFileHist", "Historic files")

AddSeparator("File details")
Add2MyTools("WSFileNav", "File navegation")
Add2MyTools("WSFileTree", "File Tree")
Add2MyTools("Telescope diagnostics", "Diagnostics")
Add2MyTools("CocDiagnostics", "Diagnostics panel")

AddSeparator("Definitions / References")
Add2MyTools("PreviewFold", "Preview fold")
Add2MyTools("DefinitionPreview", "View defs")
Add2MyTools("GotoDefinition", "Goto defs")
Add2MyTools("WSPreviewDef", "Preview defs")
Add2MyTools("WSPreviewReference", "Preview refs")
Add2MyTools("WSPreviewImplementation", "Preview implementation")
Add2MyTools("WSPreviewTypeDef", "Preview defs type")
Add2MyTools("WSPreviewCloseAll", "Close previews")

AddSeparator("Edit")
Add2MyTools("Telescope neoclip", "Yanks")
Add2MyTools("WSSearchInFile", "Search text in file")
Add2MyTools("WSSearchInDir", "Search text in directory")
Add2MyTools("WSReplaceInFile", "Replace text in files")
Add2MyTools("WSReplaceInLineComp", "Replace text in line")

AddSeparator("Editor")
Add2MyTools("NoNeckPain", "Zen Mode")
Add2MyTools("WSColorSchemePicker", "ColorScheme")
Add2MyTools("MaterialStyles", "Material Styles Selector")

AddSeparator("Terminal")
Add2MyTools("WSTerminalToggle", "Toggle Terminal")
Add2MyTools("WSTerminalExit", "Kill Terminal")
Add2MyTools("Lgit", "LazyGit")

AddSeparator("Close")
Add2MyTools("WSCloseBuffer", "Close buffer")
Add2MyTools("WSCloseEditor", "Close editor")
EOF
