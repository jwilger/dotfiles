vim.o.sidescrolloff = 20
vim.o.scrolloff = 20
vim.o.cc = 80
vim.o.showtabline = 0

lvim.builtin.bufferline.active = false
lvim.builtin.breadcrumbs.active = false
lvim.builtin.lualine.active = true
local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_c = {
  components.diff,
  components.python_env,
  components.filename
}
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "tokyonight-midnight"
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["j"] = "jzz"
lvim.keys.normal_mode["k"] = "kzz"
lvim.keys.normal_mode["G"] = "Gzz"
lvim.keys.normal_mode["<C-f>"] = "<C-f>zz"
lvim.keys.normal_mode["<C-b>"] = "<C-b>zz"
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
lvim.keys.normal_mode["<leader>xx"] = "<cmd>TroubleToggle<cr>"
lvim.keys.normal_mode["<leader>i"] =
"<cmd>lua vim.diagnostic.open_float({focusable=true, focus=true, scope=\"cursor\"}, {focusable=true, focus=true, scope=\"cursor\"})<cr>"
lvim.keys.normal_mode["<leader>v"] = "<cmd>vsplit<cr>"
lvim.keys.insert_mode["jk"] = "<Esc>"
lvim.keys.insert_mode["<C-l>"] = "<Esc>A"
lvim.keys.insert_mode["<C-h>"] = "<Esc>I"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "jsonc",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust-analyzer", "tailwindcss" })
local opts = {
  root_dir = function(fname)
    local util = require "lspconfig/util"
    return util.root_pattern("assets/tailwind.config.js", "tailwind.config.js", "tailwind.config.cjs", "tailwind.js",
      "tailwind.cjs")(fname)
  end,
  init_options = {
    userLanguages = { heex = "html", elixir = "html" }
  },
}
require("lvim.lsp.manager").setup("tailwindcss", opts)
lvim.lsp.on_attach_callback = function(client, bufnr)
  local function setup_diags()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      {
        virtual_text = false,
        signs = true,
        update_in_insert = true,
        underline = true
      }
    )
  end
  setup_diags()
end
lvim.plugins = {
  {
    "github/copilot.vim",
    config = function()
      -- copilot assume mapped
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    "hrsh7th/cmp-copilot",
    config = function()
      lvim.builtin.cmp.formatting.source_names["copilot"] = "( )"
      table.insert(lvim.builtin.cmp.sources, 2, { name = "copilot" })
    end,
  },
  { "jwilger/nord.nvim" },
  { "jamestthompson3/nvim-remote-containers" },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local status_ok, rust_tools = pcall(require, "rust-tools")
      if not status_ok then
        return
      end

      local opts = {
        tools = {
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = require("lvim.lsp").common_on_attach,
          on_init = require("lvim.lsp").common_on_init,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy"
              }
            }
          },
        },
      }
      rust_tools.setup(opts)
    end,
    ft = { "rust", "rs" },
  },
  {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        auto_open = false,
        auto_close = true
      }
    end
  },
}
