local js_based_langs = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
return {
	{
		"microsoft/vscode-js-debug",
		version = "1.*",
		build = "npm install --legacy-peer-deps && npm run compile",
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			local adapters = {
				"node",
				"pwa-node",
				"pwa-chrome",
				"pwa-msedge",
				"node-terminal",
				"pwa-extensionHost",
			}

			for _, type in ipairs(adapters) do
				local host = "::1"
				-- local port = 8123
				dap.adapters[type] = {
					type = "server",
					host = host,
					port = "${port}",
					executable = {
						command = "node",
						-- 💀 Make sure to update this path to point to your installation
						args = {
							-- download the fucking dap from microsoft/vscode-js-debug directly
							-- choose the version 1.77++ and extract the tar file and place it anywhere on the system
							-- and include the /path/to/js-debug/src/dapDebugServer.js
							"/home/dfyta9/dap/js-debug/src/dapDebugServer.js",
							"${port}",
						},
					},
				}
			end

			for _, language in ipairs(js_based_langs) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch JS file",
						cwd = vim.fn.getcwd(),
						runtimeExecutable = "node",
						args = { "${file}" },
						console = "integratedTerminal", -- or "externalTerminal"
						outputCapture = "std",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach pwa-node",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
						-- sourceMaps = true,
					},
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch & Debug Chrome",
						url = function()
							local co = coroutine.running()
							return coroutine.create(function()
								vim.ui.input({
									prompt = "Enter URL: ",
									default = "http://localhost:3000",
								}, function(url)
									if url == nil or url == "" then
										return
									else
										coroutine.resume(co, url)
									end
								end)
							end)
						end,
						webRoot = vim.fn.getcwd(),
						protocol = "inspector",
						sourceMaps = true,
						userDataDir = false,
					},
					{
						type = "",
						name = "------- using launch.json -------",
					},
				}
			end

			-- basic config on dap-debugger keymaps
			vim.keymap.set("n", "<F2>", require("dap").continue)
			vim.keymap.set("n", "<F3>", require("dap").step_over)
			vim.keymap.set("n", "<F4>", require("dap").step_into)
			vim.keymap.set("n", "<F5>", require("dap").step_out)
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
