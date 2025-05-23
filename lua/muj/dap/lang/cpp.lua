local dap = require("dap")

dap.adapters.codelldb = {
	type = "executable",
	command = "/home/dfyta9/dap/codellb/extension/adapter/codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

	-- On windows you may have to uncomment this:
	-- detached = false,
}

local c_fam = { "c", "cpp", "c++" }

for _, language in ipairs(c_fam) do
	dap.configurations[language] = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			args = function()
				local argument_string = vim.fn.input("Program arg(s) (enter nothing to leave it null): ")
				return vim.fn.split(argument_string, " ", true)
			end,
			stopOnEntry = false,
		},
	}
end
