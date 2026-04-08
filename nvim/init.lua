-----------------------------------------------
--- SHARED VARIABLES
-----------------------------------------------
local ICONS = {
	error = "",
	warn = "",
	info = "",
	hint = "",
	neovim = "",
	branch = "",
	braces = "󰅩",
}

local TS_LANGUAGES = {
	"lua",
	"rust",
	"html",
	"css",
	"c",
	"cpp",
	"rust",
	"typescript",
	"json",
	"toml",
	"markdown",
	"python",
	"cmake",
	"fish",
	"kdl",
}
local LSP_SERVERS = {
	"cssls",
	"jsonls",
	"html",
	"intelephense",
	"rust_analyzer",
	"yamlls",
	"lua_ls",
	"ts_ls",
	"cmake",
	"clangd",
	"basedpyright",
	"emmet_language_server",
	"tailwindcss",
}

-----------------------------------------------
--- BASE SETTINGS
-----------------------------------------------
vim.g.mapleader = " "
vim.opt.cmdheight = 0
vim.opt.fileencoding = "utf-8"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.filetype = "on"
vim.opt.ignorecase = true
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=2")

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = ICONS.error,
			[vim.diagnostic.severity.WARN] = ICONS.warn,
			[vim.diagnostic.severity.INFO] = ICONS.info,
			[vim.diagnostic.severity.HINT] = ICONS.hint,
		},
	},
	float = { border = "rounded" },
})

-----------------------------------------------
--- LSP Config
-----------------------------------------------
vim.lsp.enable(LSP_SERVERS)

-----------------------------------------------
--- PLUGINS INSTALL
-----------------------------------------------
vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/romgrk/barbar.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-neo-tree/neo-tree.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/christoomey/vim-tmux-navigator",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/neovim/nvim-lspconfig",
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.*" },
	{ src = "https://github.com/altermo/ultimate-autopair.nvim", version = "v0.6" },
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/akinsho/toggleterm.nvim",
	"https://github.com/fedepujol/move.nvim",
})

-----------------------------------------------
--- PLUGINS CONFIG
-----------------------------------------------
vim.cmd([[colorscheme gruvbox]])
local auto_pairs = require("ultimate-autopair").setup()
local blink = require("blink.cmp")
local lualine = require("lualine")
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local conform = require("conform")
local treesitter = require("nvim-treesitter")
local toggleterm = require("toggleterm")
local move = require("move")
local barbar = require("barbar")
local neotree = require("neo-tree")

local Terminal = require("toggleterm.terminal").Terminal
treesitter.install(TS_LANGUAGES)

mason.setup()
lualine.setup()
mason_lsp.setup()
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
		php = { "pretty-php" },
		javascript = { "prettierd" },
		css = { "prettierd" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		html = { "prettierd" },
		markdown = { "prettierd" },
		yaml = { "prettierd" },
		json = { "prettierd" },
	},
})
blink.setup({
	fuzzy = {
		implementation = "lua",
		prebuilt_binaries = { force_version = "v1" },
	},
	keymap = {
		preset = "enter",
		["<S-Tab>"] = { "select_prev", "fallback_to_mappings" },
		["<Tab>"] = { "select_next", "fallback_to_mappings" },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
})

move.setup({
	char = { enable = true },
})

toggleterm.setup({
	shade_terminals = false,
	direction = "float",
	float_opts = { border = "rounded", width = 80, height = 25 },
	highlights = {
		FloatBorder = {
			link = "FloatBorder",
		},
	},
})
barbar.setup()

-----------------------------------------------
--- KEYMAPS
-----------------------------------------------
local K = {}

function K.L(rhs)
	return "<leader>" .. rhs
end
function K.C(rhs)
	return "<C-" .. rhs .. ">"
end
function K.A(rhs)
	return "<A-" .. rhs .. ">"
end
function K.cmd(args)
	return "<cmd>" .. args .. "<cr>"
end
function K.cmd2(args)
	return ":" .. args .. "<cr>"
end

vim.keymap.set("i", "jj", "<esc>")

vim.keymap.set("n", "|", K.cmd2("vsplit"))
vim.keymap.set("n", "-", K.cmd("split"))

vim.keymap.set("n", "bn", K.cmd("bn"))
vim.keymap.set("n", "bp", K.cmd("bp"))
vim.keymap.set("n", "bd", K.cmd("bd"))

vim.keymap.set("n", K.L("e"), K.cmd2("Neotree toggle"))
vim.keymap.set("n", K.L("r"), K.cmd("restart"))
vim.keymap.set("n", K.L("w"), K.cmd("w"))
vim.keymap.set("n", K.C("s"), K.cmd("w"))
vim.keymap.set("n", K.L("W"), K.cmd("w!"))
vim.keymap.set("n", K.L("q"), K.cmd("q"))
vim.keymap.set("n", K.L("Q"), K.cmd("q!"))
vim.keymap.set("n", K.C("q"), K.cmd("q!"))

vim.keymap.set("v", "q", "<esc>")

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", K.C("h"), K.cmd("wincmd h"))
vim.keymap.set("t", K.C("j"), K.cmd("wincmd j"))
vim.keymap.set("t", K.C("k"), K.cmd("wincmd k"))
vim.keymap.set("t", K.C("l"), K.cmd("wincmd l"))

vim.keymap.set("n", K.L("ff"), K.cmd("Telescope find_files"))
vim.keymap.set("n", K.C("Space"), K.cmd("Telescope find_files"))
vim.keymap.set("n", K.C("p"), K.cmd("Telescope find_files"))

vim.keymap.set("n", K.A("k"), K.cmd("MoveLine(-1)"))
vim.keymap.set("n", K.A("j"), K.cmd("MoveLine(1)"))
vim.keymap.set("n", K.A("h"), K.cmd("MoveHChar(-1)"))
vim.keymap.set("n", K.A("l"), K.cmd("MoveHChar(1)"))

vim.keymap.set("v", K.A("j"), K.cmd2("MoveBlock(1)"))
vim.keymap.set("v", K.A("k"), K.cmd2("MoveBlock(-1)"))
vim.keymap.set("v", K.A("h"), K.cmd2("MoveHBlock(-1)"))
vim.keymap.set("v", K.A("l"), K.cmd2("MoveHBlock(1)"))

vim.keymap.set("n", K.L("tf"), K.cmd("ToggleTerm"))
vim.keymap.set("n", K.C("t"), K.cmd("ToggleTerm"))

vim.keymap.set("n", K.L("tl"), function()
	Terminal:new({ cmd = "lazygit" }):open()
end)

-- barbar config
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-n>", "<Cmd>BufferNext<CR>", opts)

-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

-- Goto buffer in position...
map("n", "<A-&>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-é>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", '<A-">', "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-'>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-(>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-->", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-è>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-_>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-ç>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-à>", "<Cmd>BufferLast<CR>", opts)

-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
-- Close buffer
map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)

---------------------------------------------------------
--- AUTO START
---------------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
