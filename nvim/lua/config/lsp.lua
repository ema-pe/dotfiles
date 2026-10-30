-- My personal LSP configuration. Neovim must be of versione >0.12!

-- Python LSP (Pyright) activation. Pyright must be installed via uv with the
-- following command:
--
--      uv tool install pyright
--
-- The LSP server will be started on demand. If pyright is not available, it
-- will be skipped.
if vim.fn.executable("pyright-langserver") == 1 then
  vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },

    filetypes = { "python" },

    exit_timeout = 10000, -- Wait 10 seconds before terminating Pyright.

    root_markers = {
      "pyproject.toml",
      "pyrightconfig.json",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      ".git",
    },

    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
        },
      },
    },
  })

  vim.lsp.enable("pyright")
end

-- Go LSP server. Must be installed with the following command:
--
--      go install golang.org/x/tools/gopls@latest
--
-- The configuration works like for Pyright.
if vim.fn.executable("gopls") == 1 then
  vim.lsp.config("gopls", {
    cmd = { "gopls" },

    filetypes = {
      "go",
      "gomod",
      "gowork",
    },

    exit_timeout = 10000, -- Same as pyright.

    root_markers = {
      "go.work",
      "go.mod",
      ".git",
    },

    settings = {
      gopls = {
        gofumpt = true,
        staticcheck = true,

        analyses = {
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
      },
    },
  })

  vim.lsp.enable("gopls")
end

-- Built-in LSP completion. Turn it on for every client that supports it.
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }

-- Enable completion only if the LSP server supports it. We must do this
-- manually, every time a LSP client attaches to a buffer.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),

  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

-- Configure how the diagnostics are displayed.
vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = true },
  virtual_text = { source = "if_many" },
})

-- <Space>cd will one the diagnostics dialog.
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show diagnostic" })
