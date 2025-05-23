return {
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = function()
			local dap = require("dap")

			dap.defaults.fallback.terminal_win_cmd = "belowright split | terminal"
			-- basic config on dap-debugger keymaps
			require("muj.dap.lang.jsts")
			require("muj.dap.lang.cpp")

			vim.keymap.set("n", "<F2>", require("dap").continue)
			vim.keymap.set("n", "<F3>", require("dap").step_over)
			vim.keymap.set("n", "<F4>", require("dap").step_into)
			vim.keymap.set("n", "<F5>", require("dap").step_out)
			vim.keymap.set("n", "<F6>", require("dap").clear_breakpoints)
			vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)
			vim.keymap.set("n", "<leader>B", function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end)

			vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "🟧", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapLogPoint", { text = "🟩", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "🈁", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "⬜", texthl = "", linehl = "", numhl = "" })
		end,
		keys = {
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<leader>da",
				function()
					local js_based_langs = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

					if vim.fn.filereadable(".vscode/launch.json") then
						local dap_vscode = require("dap.ext.vscode")
						dap_vscode.load_launchjs(nil, {
							["node"] = js_based_langs,
							["pwa-node"] = js_based_langs,
							["chrome"] = js_based_langs,
							["pwa-chrome"] = js_based_langs,
						})
					end
					require("dap").continue()
				end,
				desc = "Run with Args",
			},
		},
	},
}
