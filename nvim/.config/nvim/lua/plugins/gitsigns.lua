return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup()

			local map = vim.keymap.set

			map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview Hunk" })
			map("n", "<leader>gb", ":Gitsigns blame<CR>", { desc = "Blame" })
			map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle Line Blame" })
		end
	}
}
