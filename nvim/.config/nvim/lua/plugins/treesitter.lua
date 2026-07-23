return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- dependencies = { "nvim-lua/plenary.nvim", "neovim-treesitter/treesitter-parser-registry" },
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			-- Explicitly install parsers you want
			local parsers = {
				"svelte",
				"javascript",
				"typescript",
				"lua",
				"python",
				"html",
				"css",
				"jsx",
				"tsx",
				"rust",
			}
			require("nvim-treesitter").install(parsers):wait(300000)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(function()
						local ft = vim.bo[args.buf].filetype
						local lang = vim.treesitter.language.get_lang(ft)
						if not lang then
							return
						end
						if not vim.tbl_contains(parsers, lang) then
							return
						end
						if not vim.treesitter.language.add(lang) then
							return
						end
						vim.treesitter.start(args.buf, lang)
						vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					end)
				end,
			})
		end,
	},
}
