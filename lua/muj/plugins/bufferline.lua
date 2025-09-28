return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"tiagovla/scope.nvim",
		"moll/vim-bbye",
	},

	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				diagnostics = "nvim_lsp",
				separator_style = "slant", -- or "padded_slant", "thick"
				always_show_bufferline = true,
				show_tab_indicators = true,
				buffer_close_icon = "󰅖",
				close_command = "Bdelete! %d",

				offsets = {
					{
						filetype = "neo-tree",
						text = function()
							return vim.fn.getcwd()
						end,
						highlight = "Directory",
						separater = true,
					},
				},

				numbers = function(opts) -- straight for help
					return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
				end,

				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
			},
			highlights = {
				fill = { bg = nil }, -- area behind slants
				background = { bg = nil }, -- non-active buffer background
				buffer_visible = { bg = nil },
				buffer_selected = { bg = nil },
				tab = { bg = nil },
				tab_close = { bg = nil },
				close_button = { bg = nil },
				close_button_visible = { bg = nil },
				close_button_selected = { bg = nil },
				separator = { bg = nil },
				separator_selected = { bg = nil },
				separator_visible = { bg = nil },
			},
		})

		require("scope").setup()

		local function ensure_scratch()
			-- Count listed buffers
			local listed = vim.fn.getbufinfo({ buflisted = 1 })

			-- If nothing left, or only Neo-tree left, create a scratch
			if #listed == 0 or (#listed == 1 and listed[1].name:match("neo%-tree")) then
				vim.cmd("enew")
				vim.bo.bufhidden = "hide"
				vim.bo.buftype = "nofile"
				vim.bo.buflisted = true
				vim.bo.swapfile = false
				vim.api.nvim_buf_set_name(0, "Home")
			end
		end

		vim.api.nvim_create_autocmd({ "BufDelete", "QuitPre" }, {
			callback = ensure_scratch,
		})

		-- local function open_alpha_safely()
		-- 	-- if Alpha command exists, create a valid listed buffer first, then call Alpha
		-- 	if vim.fn.exists(":Alpha") == 2 then
		-- 		-- create a listed buffer (so it's counted by getbufinfo)
		-- 		local buf = vim.api.nvim_create_buf(true, false) -- listed=true, scratch=false
		--
		-- 		if buf and vim.api.nvim_buf_is_valid(buf) then
		-- 			-- set it up as a lightweight nofile buffer
		-- 			vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
		-- 			vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
		-- 			vim.api.nvim_buf_set_option(buf, "swapfile", false)
		-- 			vim.api.nvim_buf_set_name(buf, "Home")
		--
		-- 			-- make it the current buffer so Alpha has a stable buffer to attach to
		-- 			vim.api.nvim_set_current_buf(buf)
		--
		-- 			-- small defer to avoid racing with other autocmds/plugins
		-- 			vim.defer_fn(function()
		-- 				pcall(vim.cmd, "Alpha")
		-- 			end, 50) -- 50ms should be plenty; increase if you still see races
		-- 			return
		-- 		end
		-- 	end
		--
		-- 	-- fallback if Alpha not available or buffer creation failed:
		-- 	vim.cmd("enew")
		-- 	vim.bo.bufhidden = "hide"
		-- 	vim.bo.buftype = "nofile"
		-- 	vim.bo.buflisted = true
		-- 	vim.bo.swapfile = false
		-- 	vim.api.nvim_buf_set_name(0, "Home")
		-- end
		--
		-- local function ensure_scratch()
		-- 	local listed = vim.fn.getbufinfo({ buflisted = 1 })
		-- 	if #listed == 0 or (#listed == 1 and listed[1].name:match("neo%-tree")) then
		-- 		-- schedule to next tick to avoid doing this while buffers are mid-delete
		-- 		vim.schedule(open_alpha_safely)
		-- 	end
		-- end
		--
		-- vim.api.nvim_create_autocmd({ "BufDelete", "QuitPre" }, {
		-- 	callback = ensure_scratch,
		-- })
	end,
}
