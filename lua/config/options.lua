-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

print("Loading options.lua")

opt.autowrite = false -- Enable auto write
opt.expandtab = true -- Use spaces instead of tabs
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 99 -- Maximum number of entries in a popup
opt.ruler = false -- Disable the default ruler
opt.scrolloff = 3 -- Lines of context
opt.shiftwidth = 2 -- Size of an indent
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 0 -- Columns of context
opt.signcolumn = "no" -- Always show the signcolumn, otherwise it would shift the text each time
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 4 -- Number of spaces tabs count for
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 2 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.smoothscroll = false
opt.scrolloff = 0
vim.opt.undofile = true
vim.opt.gdefault = true
vim.opt.hlsearch = true

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.g.snacks_animate = false
-- vim.g.snacks_dashboard = false
