-- vim:foldmethod=marker
--
-- My own Neovim configuration.
--
-- Copyright (c) 2024 Emanuele Petriglia (ema-pe) <inbox@emanuelepetriglia.com>.
-- All right reserved. This script is licensed under the MIT license.

-- Show line numbers.
vim.opt.number = true

-- Show by default relative line numbers.
vim.opt.relativenumber = true

-- Toggle a boolean options with name "name". Also print status message prefixed
-- with "message".
-- Thanks to /u/Mhalter3378 on Reddit.
local function vim_opt_toggle(name, message)
    if not vim.o[name] then
        vim.opt[name] = true
        message = message .. " enabled"
    else
        vim.opt[name] = false
        message = message .. " disabled"
    end

    vim.notify(message)
end

-- Toggle between absolute or relative numbers with <Tab>.
vim.keymap.set("n", "<Tab>", function() vim_opt_toggle("relativenumber", "Relative numbers") end)

-- Highlight brackets. See https://neovim.io/doc/user/options.html#'showmatch'
vim.opt.showmatch = true

-- Clear highlighted text after search, because by default it remains
-- highlighted.
vim.keymap.set("n", "\\q", "<cmd>nohlsearch<cr>")

-- Folding options {{{

-- Enable automatic code folding according to the indentation.
-- See https://neovim.io/doc/user/options.html#'foldmethod'
vim.opt.foldmethod = "indent"

-- Close automatically folds starting from the given level (all folds).
-- See https://neovim.io/doc/user/options.html#'foldlevel'
vim.opt.foldlevel = 0

-- Set at most two nesting folds.
-- See https://neovim.io/doc/user/options.html#'foldnestmax'
vim.opt.foldnestmax = 2

-- Open/Close the current fold.
vim.keymap.set("n", "<space>", "za")

-- }}}

-- Enables 24-bit RGB color (I use xfce4-terminal, so I'm sure that it supports
-- true colors).
vim.opt.termguicolors = true

-- TODO: add a theme.
-- vim.opt.colorscheme = "???"

-- Highlight the final spaces in a line and tabs. 
vim.opt.listchars = {trail = "‧", tab = "››"}

-- Maximum width of text that is being inserted. Longer lines will be wrapped.
vim.opt.textwidth = 80

-- Color the next column after textwidth, so I can understand where is the
-- limit.
vim.opt.colorcolumn = "+1"

-- Tab and spaces settings {{{

-- The default values are 8 spaces for a tab. But by default I prefer 4 spaces.
vim.opt.tabstop = 4 -- Set 4 spaces for a tab when is read.
vim.opt.shiftwidth = 4 -- Set 4 spaces when inserting a tab.
vim.opt.expandtab = true -- Insert spaces instead of tab.

-- Insert a tab with 'Shift+Tab'.
vim.keymap.set("i", "<S-Tab>", "<C-V><Tab>")

-- TODO

-- }}}

-- Load 'redact_pass', a 'pass' plugin to improve secutiry when editing a
-- password using Neovim. If not available, ignore it, maybe 'pass' is not
-- installed.
pcall(vim.cmd, "source /usr/share/doc/pass/vim/redact_pass.vim")

require("config.lazy")
vim.cmd([[colorscheme modus]])
