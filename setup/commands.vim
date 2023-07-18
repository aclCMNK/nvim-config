command! -nargs=* -complete=file Search call Search(<q-args>)
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

command! -nargs=* -complete=file SearchAll call SearchAll(<q-args>)
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

command! -nargs=* -complete=file ReplaceAll call ReplaceAll(<q-args>)
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

command! -nargs=* -complete=file ReplaceInLine call ReplaceInLine(<q-args>)
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
		local success, err = pcall(vim.cmd, ":delete "..bufnr)
		if not success then
			print("Error: "..err)
			vim.cmd(":q!")
		end
	end
	vim.cmd(':q!')
end
EOF
command! CloseAll :lua CloseAll()

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
EOF
command! CloseBuffer :lua CloseBuffer()
