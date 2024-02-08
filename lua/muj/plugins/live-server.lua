return {
	"aurum77/live-server.nvim",

	config = function()
		local live_server = require("live_server")

		live_server.setup({
			port = 3000,
			browser_command = "",
			quiet = false,
			no_css_inject = false,
			install_path = vim.fn.stdpath("config") .. "/live/",
		})

		require("live_server.util").install()

		local keymap = vim.keymap

		-- keymap.set("n", "<leader>ss", "<cmd>LiveServerStart<CR>")
		-- keymap.set("n", "<leader>st", "<cmd>LiveServerStop<CR>")
	end,
}
