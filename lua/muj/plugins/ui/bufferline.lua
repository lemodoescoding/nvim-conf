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

		-- local function ensure_dashboard()
		-- 	vim.schedule(function()
		-- 		local listed = vim.fn.getbufinfo({ buflisted = 1 })
		--
		-- 		-- Filter out neo-tree from the count
		-- 		local count = 0
		-- 		for _, buf in ipairs(listed) do
		-- 			if not buf.name:match("neo%-tree") then
		-- 				count = count + 1
		-- 			end
		-- 		end
		--
		-- 		if count == 0 then
		-- 			-- Instead of manually making a "Home" buffer,
		-- 			-- just tell Snacks to open the dashboard.
		-- 			require("snacks").dashboard.open()
		-- 		end
		-- 	end)
		-- end

		local function ensure_dashboard()
			-- Guard: Only run if we are in a normal window and not already in Alpha
			if vim.bo.filetype == "alpha" or vim.bo.buftype == "terminal" then
				return
			end

			vim.schedule(function()
				local listed = vim.fn.getbufinfo({ buflisted = 1 })
				local count = 0

				for _, buf in ipairs(listed) do
					pcall(function()
						local name = buf.name or ""
						local ft = vim.api.nvim_get_option_value("filetype", { buf = buf.bufnr })

						if name ~= "" and not name:match("neo%-tree") and ft ~= "alpha" then
							count = count + 1
						end
					end)
				end

				if count == 0 then
					for _, buf in ipairs(listed) do
						pcall(vim.api.nvim_buf_delete, buf.bufnr, { force = true })

						if count == 0 then
							break
						end
					end

					pcall(vim.cmd, "Alpha")
					vim.schedule(function()
						local final_list = vim.fn.getbufinfo({ buflisted = 1 })
						for _, buf in ipairs(final_list) do
							local ft = vim.api.nvim_get_option_value("filetype", { buf = buf.bufnr })
							if buf.name == "" and ft ~= "alpha" then
								pcall(vim.api.nvim_buf_delete, buf.bufnr, { force = true })
							end
						end
					end)
				end
			end)
		end

		local agrp = vim.api.nvim_create_augroup("AlphaRetain", { clear = true })

		vim.api.nvim_create_autocmd("BufDelete", {
			group = agrp,
			callback = function()
				vim.defer_fn(ensure_dashboard, 100)
			end,
		})

		vim.api.nvim_create_autocmd("TabNewEntered", {
			group = agrp,
			callback = function()
				ensure_dashboard()
			end,
		})
	end,
}
