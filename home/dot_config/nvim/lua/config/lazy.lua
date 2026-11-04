-- vim:foldmethod=marker
--
-- My personal lazy.nvim bootstrapping and configuration.
--
-- Copyright (c) 2026 Emanuele Petriglia (ema-pe) <inbox@emanuelepetriglia.com>.
-- All right reserved. This script is licensed under the MIT license.

-- Bootstrap lazy.nvim
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

-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim
-- so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Do not use plugins for now.
    -- { import = "plugins" },

    -- Add modus colorscheme plugin.
    -- See: https://github.com/miikanissi/modus-themes.nvim
    {"miikanissi/modus-themes.nvim", priority = 1000, opts = {variants="tinted"}},
  },

  -- Set colorscheme.
  install = {colorscheme = {"modus"}},

  -- Automatically check for plugin updates.
  checker = {enabled = true},
})
