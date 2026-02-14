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

		local function safe_ensure_scratch()
			vim.schedule(function()
				local listed = vim.fn.getbufinfo({ buflisted = 1 })

				-- Avoid running during runtime checks (like :checkhealth)
				if vim.v.exiting ~= vim.NIL then
					return
				end

				-- If only Neo-tree or no buffers remain
				if #listed == 0 or (#listed == 1 and listed[1].name:match("neo%-tree")) then
					-- Create new scratch buffer
					vim.cmd("enew!")
					vim.bo.bufhidden = "hide"
					vim.bo.buftype = "nofile"
					vim.bo.buflisted = true
					vim.bo.swapfile = false

					-- Avoid renaming conflicts
					if vim.fn.bufnr("^Home$", false) == -1 then
						pcall(vim.api.nvim_buf_set_name, 0, "Home")
						vim.schedule(function()
							vim.defer_fn(function()
								pcall(vim.cmd, "Alpha")
							end, 0) -- 50ms should be plenty; increase if you still see races
						end)
					end
				end
			end)
		end

		vim.api.nvim_create_autocmd({ "BufDelete", "TabClosed" }, {
			callback = safe_ensure_scratch,
		})

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
