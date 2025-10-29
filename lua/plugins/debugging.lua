return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "mason.nvim" },
		cmd = { "DapInstall", "DapUninstall" },
		opts = {
			ensure_installed = { "codelldb" },
			automatic_installation = true,
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mason-org/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local widgets = require("dap.ui.widgets")

			dapui.setup()

			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb" },
				automatic_installation = true,
			})

			vim.api.nvim_set_hl(0, "Red", { fg = "#FF0000" })
			vim.api.nvim_set_hl(0, "RedBlack", { fg = "#690C0B" })
			vim.api.nvim_set_hl(0, "YellowBlack", { fg = "#C6CF15" })
			vim.api.nvim_set_hl(0, "Yellow", { fg = "#F1DC18" })
			vim.api.nvim_set_hl(0, "Black", { fg = "#000000" })

			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				texthl = "Red",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapStopped", {
				text = "󰜴",
				texthl = "Yellow",
				linehl = "YellowBlack",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointRejected", {
				text = "",
				texthl = "RedBlack",
				linehl = "",
				numhl = "",
			})

			vim.keymap.set("n", "<F5>", function()
				dap.continue()
			end)
			vim.keymap.set("n", "<F10>", function()
				dap.step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				dap.step_into()
			end)

			vim.keymap.set("n", "<F12>", function()
				dap.step_out()
			end)

			vim.keymap.set("n", "<Leader>b", function()
				dap.toggle_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>B", function()
				dap.set_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>lp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end)
			vim.keymap.set("n", "<Leader>dr", function()
				dap.repl.open()
			end)
			vim.keymap.set("n", "<Leader>dl", function()
				dap.run_last()
			end)
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				widgets.hover()
			end)
			vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
				widgets.preview()
			end)
			vim.keymap.set("n", "<Leader>df", function()
				widgets.centered_float(widgets.frames)
			end)
			vim.keymap.set("n", "<Leader>ds", function()
				widgets.centered_float(widgets.scopes)
			end)
			vim.keymap.set("n", "<Leader>dt", function()
				dap.terminate()
			end)

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					{
						"rcarriga/nvim-dap-ui",
						dependencies = { "nvim-neotest/nvim-nio" },
						opts = {},
					},
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}
			for _, lang in ipairs({ "c", "cpp" }) do
				dap.configurations[lang] = {
					{
						type = "codelldb",
						request = "launch",
						name = "Launch file",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
					},
					{
						type = "codelldb",
						request = "attach",
						name = "Attach to process",
						pid = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end
		end,
	},
}
