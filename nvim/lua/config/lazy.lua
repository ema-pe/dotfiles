-- vim:foldmethod=marker
--
-- lazy.nvim bootstrapping and configuration.
--
-- Copyright (c) 2026 Emanuele Petriglia (ema-pe) <inbox@emanuelepetriglia.com>.
-- All right reserved. This script is licensed under the MIT license.

-- Standard installation from https://lazy.folke.io/installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Plugins to download and load automatically.
local plugins = {
  -- Colorscheme.
  -- See: https://github.com/miikanissi/modus-themes.nvim
  {
    "miikanissi/modus-themes.nvim",
    priority = 1000,
    opts = { variants = "tinted" },
  },
}

-- Setup and start lazy.nvim.
require("lazy").setup({
  spec = plugins,

  install = {
    colorscheme = { "modus" },
  },

  checker = {
    enabled = true,
  },
})
