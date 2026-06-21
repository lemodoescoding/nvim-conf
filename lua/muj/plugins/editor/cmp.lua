return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"onsails/lspkind.nvim",
		"L3MON4D3/Luasnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		-- "jcha0713/cmp-tw2css",
	},

	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		-- local lspkind = require("lspkind")

		-- load vs-code like snippets from plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = {
				"./snippets",
			},
		})

		require("luasnip.loaders.from_vscode").lazy_load()

		vim.keymap.set("n", "<leader>ls", function()
			local ft = vim.bo.filetype
			local snippets = require("luasnip").snippets[ft]
			if not snippets then
				print("No snippets for " .. ft)
				return
			end
			for _, s in ipairs(snippets) do
				print(s.trigger)
			end
		end)

		luasnip.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		})

		vim.opt.completeopt = "menu,menuone,noselect"
		local kind_icons = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = " ",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "",
			Event = "",
			Operator = "󰆕",
			TypeParameter = " ",
			Misc = " ",
		}

		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		local compare = cmp.config.compare

		cmp.setup({
			performance = {
				debounce = 300,
				throttle = 100,
				fetching_timeout = 600,
				max_view_entries = 15,
			},
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),

				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expandable() then
						luasnip.expand()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif check_backspace() then
						fallback()
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
			}),

			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

					vim_item.menu = ({
						nvim_lsp = "[L]",
						-- nvim_lua = "[L]",
						luasnip = "[S]",
						buffer = "[B]",
						path = "[P]",
					})[entry.source.name]

					return vim_item
				end,
			},

			sources = cmp.config.sources({
				-- { name = "jupynium", priority = 1000 }, -- from jupynium
				{ name = "nvim_lsp", priority = 1000 },
				{ name = "luasnip", priority = 750, max_item_count = 5 }, -- snippets
				{
					name = "buffer",
                    priority = 100,
                    max_item_count = 5,
					option = {
						get_bufnrs = function()
							return { vim.api.nvim_get_current_buf() }
						end,
						max_indexed_line_length = 100,
					},
				}, -- text within buffer
				{ name = "path", priority = 500}, -- file system path
			}),

			sorting = {
				priority_weight = 2.0,
				comparators = {
					compare.offset,
					compare.exact, -- exact matches first
					compare.score,
					compare.recently_used,
					compare.kind, -- LSP kinds (Function, Method etc.) ranked higher
					compare.locality,
					compare.sort_text,
					compare.length,
					compare.order,
					-- ...
				},
			},

			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},

			window = {
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
			},
		})
	end,
}
