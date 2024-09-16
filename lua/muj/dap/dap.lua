local js_based_langs = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
return {
	{ "nvim-neotest/nvim-nio" },
	{
		"mxsdev/nvim-dap-vscode-js",
		config = function()
			local node_path = os.getenv("HOME") .. "/.nvm/versions/node/v22.4.1/bin/node"

			local dap = require("dap")
			local adapters = {
				"node",
				"chrome",
				"pwa-node",
				"pwa-chrome",
				"pwa-msedge",
				"node-terminal",
				"pwa-extensionHost",
			}

			-- require("dap-vscode-js").setup({
			-- 	debugger_path = ,
			-- 	adapters = adapters,
			-- })

			for _, type in ipairs(adapters) do
				local host = "::1"
				dap.adapters[type] = {
					type = "server",
					host = host,
					port = "${port}",
					executable = {
						command = "js-debug-adapter",
						args = { "${port}" },
					},
				}
			end

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "::1",
				port = "${port}",
				executable = {
					command = "js-debug-adapter",
					args = { "~/js-debug-dap-v1.93.0/js-debug/src/dapDebugServer.js", "${port}" },
				},
			}
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"microsoft/vscode-js-debug",
				build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
			},
		},
		config = function()
			local dap = require("dap")

			for _, language in ipairs(js_based_langs) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch current file using pwa-node",
						program = "${file}",
						cwd = "${workspaceFolder}",
						-- sourceMaps = true,
						-- runtimeExecutable = "node",
						-- stopOnEntry = true,
						-- protocol = "inspector",
						-- console = "integratedTerminal",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach pwa-node",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
						port = "${port}",
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
		-- -- basic config on dap-debugger keymaps
		-- vim.keymap.set("n", "<F5>", require("dap").continue)
		-- vim.keymap.set("n", "<F10>", require("dap").step_over)
		-- vim.keymap.set("n", "<F11>", require("dap").step_into)
		-- vim.keymap.set("n", "<F12>", require("dap").step_out)
		-- vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)
		-- vim.keymap.set("n", "<leader>B", function()
		-- 	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		-- end)
	},
}
