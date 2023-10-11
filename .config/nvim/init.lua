-- Adapted from https://github.com/nvim-lua/kickstart.nvim
-- Install vim-plug
local install_path = vim.fn.stdpath("data") .. "/site"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute(
    "!curl -fLo" ..
    install_path ..
    "/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
end

-- register plugins
local Plug = vim.fn["plug#"]
vim.call("plug#begin")
Plug "tpope/vim-commentary"
Plug "tpope/vim-fugitive"
Plug "tpope/vim-surround"
Plug "tpope/vim-vinegar"
Plug "tpope/vim-repeat"
Plug "vim-test/vim-test"
Plug "rebelot/kanagawa.nvim"
Plug "ojroques/nvim-osc52"
Plug "b0o/schemastore.nvim"
Plug "nvim-lua/plenary.nvim"
Plug "nvim-lualine/lualine.nvim"
Plug "nvim-telescope/telescope.nvim"
Plug("nvim-telescope/telescope-fzf-native.nvim", { ["do"] = "make" })
Plug "lewis6991/gitsigns.nvim"
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug "github/copilot.vim"
Plug "neovim/nvim-lspconfig"
Plug "williamboman/mason.nvim"
Plug "williamboman/mason-lspconfig.nvim"
Plug "stevearc/conform.nvim"
Plug "hrsh7th/nvim-cmp"
Plug "hrsh7th/cmp-nvim-lsp"
Plug "L3MON4D3/LuaSnip"
Plug "saadparwaiz1/cmp_luasnip"
vim.call("plug#end")

--Integrate with system clipboard
vim.o.clipboard = "unnamedplus"
local function copy(lines, _)
  require("osc52").copy(table.concat(lines, "\n"))
end

local function paste()
  return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end

vim.g.clipboard = {
  name = "osc52",
  copy = { ["+"] = copy, ["*"] = copy },
  paste = { ["+"] = paste, ["*"] = paste },
}

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.o.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.wo.signcolumn = "yes"

--Set colorscheme
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

--Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- colorscheme
require("kanagawa").setup({
  colors = {
    theme = { all = { ui = { bg_gutter = "none" } } }
  },
  transparent = true
})
vim.cmd("colorscheme kanagawa")

-- telescope
require("telescope").setup({
  {
    defaults = {
      layout_strategy = "vertical",
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-d>"] = false,
        },
      },
    },
  }
})

-- gitsigns
require("gitsigns").setup({
  current_line_blame = true
})


-- lualine
local theme = require("lualine.themes.kanagawa")
theme.normal.c.bg = "NONE"
local fg = "#DCD7BA"
require("lualine").setup({
  options = {
    icons_enabled = false,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
    theme = theme,
  },
  sections = {
    lualine_a = {
      {},
    },
    lualine_b = {
      {
        "branch",
        color = { fg = fg, bg = "NONE" },
      },
      {
        "diff",
        color = { bg = "NONE" },
      },
      {
        "diagnostics",
        color = { bg = "NONE" },
      },
    },
    lualine_x = {
      {},
    },
    lualine_y = {
      {
        "progress",
        color = { fg = fg, bg = "NONE" },
      },
    },
    lualine_z = {
      {
        "location",
        color = { fg = fg, bg = "NONE" },
      },
    },
  }
})

-- Enable telescope fzf native
require("telescope").load_extension("fzf")

-- Telescope keymaps
local telescope_builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader><space>", function()
  telescope_builtin.buffers({ layout_strategy = "vertical" })
end)
vim.keymap.set("n", "<leader>f", function()
  telescope_builtin.find_files({ layout_strategy = "vertical", hidden = true })
end)
vim.keymap.set("n", "<leader>b", telescope_builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>h", telescope_builtin.help_tags)
vim.keymap.set("n", "<leader>t", telescope_builtin.tags)
vim.keymap.set("n", "<leader>d", telescope_builtin.diagnostics)
vim.keymap.set("n", "<leader>g", function()
  telescope_builtin.live_grep({ layout_strategy = "vertical" })
end)
vim.keymap.set("n", "<leader>?", telescope_builtin.oldfiles)

-- Treesitter configuration
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "vim", "c", "lua", "comment", "bash", "html", "css", "scss", "json", "jsonc", "jsdoc", "typescript",
    "javascript", "markdown", "yaml", "toml", "rust", "go", "python", "php", "ruby", "dockerfile", "sql"
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- LSP settings
vim.diagnostic.config({
  virtual_text = {
    source = "always",
  },
  float = {
    source = "always",
  },
})
local lspconfig = require("lspconfig")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", function()
    telescope_builtin.lsp_references({ layout_strategy = "vertical" })
  end, opts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>ds", telescope_builtin.lsp_document_symbols, opts)
  vim.keymap.set("n", "<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, opts)

  -- format on save
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({
        bufnr,
        filter = function(client)
          -- never format with jsonls
          return client.name ~= "jsonls" or client.name ~= "eslint"
        end
      })
    end
  })
end

-- for ts/js projects, conform.nvim handles prettier
require("conform").setup({
  formatters_by_ft = {
    json = { { "prettierd", "prettier" } },
    jsonc = { { "prettierd", "prettier" } },
    javascriptreact = { { "prettierd", "prettier" } },
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    typescriptreact = { { "prettierd", "prettier" } },
  },
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
})

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup mason so it can manage external tooling (LSPs)
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require "mason-lspconfig"

-- Enable the following language servers
local servers = {
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  dockerls = {},
  terraformls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }

    lspconfig.jsonls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }

    lspconfig.eslint.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = lspconfig.util.root_pattern("package.json"),
    }

    lspconfig.tsserver.setup {
      capabilities = capabilities,
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
      end,
      root_dir = lspconfig.util.root_pattern("package.json"),
    }
  end,
}

-- vim-test
vim.g["test#runner_commands"] = { "Jest", "Mocha" }

-- luasnip setup
local luasnip = require("luasnip")

-- github copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})
-- vim: ts=2 sts=2 sw=2 et
