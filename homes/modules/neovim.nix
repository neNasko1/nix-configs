{ lib, config, pkgs, inputs, ... }:

let
  vi_action = action: "<CMD>${action}<CR>";
  lua_action = action: "<CMD>lua ${action}<CR>";
  default_km_opts = {
    remap = false;
    silent = true;
  };

  clangd_cmd = [
    "clangd"
    "--background-index"
    "--clang-tidy"
    "--header-insertion=iwyu"
    "--completion-style=detailed"
    "--function-arg-placeholders"
    "--fallback-style=llvm"
  ];
in
  {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    globals.mapleader = " ";
    globals.maplocalleader = " ";
    globals.copilot_enabled = 0;

    plugins = {
      treesitter = {
        enable = true;
        settings = {
          auto_install = false;
          ensure_installed = [ "c" "cpp" ];
          highlight.enable = true;
          incremental_selection.enable = true;
          indent.enable = true;
        };
      };

      lsp = {
        enable = true;

        servers = {
          ruff.enable = true;

          clangd = {
            enable = true;
            packageFallback = true;
            cmd = clangd_cmd;
            filetypes = [ "c" "cpp" "objc" "objcpp" "cuda" ];
            rootMarkers = [
              "compile_commands.json"
              "compile_flags.txt"
              "Makefile"
              "configure.ac"
              "configure.in"
              "config.h.in"
              "meson.build"
              "meson_options.txt"
              "build.ninja"
              ".git"
            ];
            extraOptions = {
              init_options = {
                usePlaceholders = true;
                completeUnimported = true;
                clangdFileStatus = true;
              };
            };
          };

          starpls.enable = true;
        };

        keymaps = {
          silent = true;

          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gi" = "implementation";
            "gr" = "references";
            "ca" = "code_action";
            "K" = "hover";
          };

          extra = [
            {
              key = "ff";
              action.__raw = "function() vim.lsp.buf.format({ async = true }) end";
              options = { silent = true; };
            }
            {
              key = "<SPACE>cR";
              action.__raw = ''
                function()
                  if vim.lsp.get_clients({ bufnr = 0, name = "clangd" })[1] ~= nil then
                    vim.cmd("ClangdSwitchSourceHeader")
                  end
                end
              '';
              options = { silent = true; };
            }
          ];
        };
      };

      clangd-extensions = {
        enable = true;
        enableOffsetEncodingWorkaround = true;
        settings = {
          ast = {
            role_icons = {
              type = "T";
              declaration = "D";
              expression = "E";
              specifier = "S";
              statement = "St";
              "template argument" = "TA";
            };
            kind_icons = {
              Compound = "C";
              Recovery = "R";
              TranslationUnit = "TU";
              PackExpansion = "PE";
              TemplateTypeParm = "TTP";
              TemplateTemplateParm = "TTP";
              TemplateParamObject = "TPO";
            };
          };
        };
      };

      telescope = {
        enable = true;
      };

      gitgutter.enable = true;
      fugitive.enable = true;

      luasnip.enable = true;

      cmp = {
        enable = true;
        settings = {
          snippet = {
            expand = ''
              function(args)
                require("luasnip").lsp_expand(args.body)
              end
            '';
          };

          sources = [
            { name = "path"; }
            { name = "nvim_lsp"; }
            { name = "luasnip"; keyword_length = 2; }
          ];

          mapping.__raw = ''
            require("cmp").mapping.preset.insert({
              ["<Tab>"] = require("cmp").mapping.confirm({ select = true }),
            })
          '';

          sorting = {
            comparators = [
              "require('cmp.config.compare').offset"
              "require('cmp.config.compare').exact"
              "require('cmp.config.compare').score"
              "require('clangd_extensions.cmp_scores')"
              "require('cmp.config.compare').recently_used"
              "require('cmp.config.compare').kind"
              "require('cmp.config.compare').sort_text"
              "require('cmp.config.compare').length"
              "require('cmp.config.compare').order"
            ];
          };

          experimental = {
            ghost_text = true;
          };
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            timeout_ms = 500;
          };
          formatters_by_ft = {
            "*" = [ "trim_whitespace" ];
          };
        };
      };
    };


    keymaps = [
      {
        key = "[d";
        action = lua_action "vim.diagnostic.goto_prev()";
        options = default_km_opts;
      }
      {
        key = "]d";
        action = lua_action "vim.diagnostic.goto_next()";
        options = default_km_opts;
      }
      {
        mode = [ "n" "x" ];
        key = "<SPACE>y";
        action = ''"+y'';
        options = default_km_opts;
      }
      {
        mode = "n";
        key = "<SPACE>Y";
        action = ''"+Y'';
        options = default_km_opts;
      }
      {
        key = "<SPACE>tf";
        action = vi_action "Telescope git_files";
        options = default_km_opts;
      }
      {
        key = "<SPACE>tg";
        action = vi_action "Telescope live_grep";
        options = default_km_opts;
      }
    ];

    performance = {
      byteCompileLua = {
        enable = true;
        initLua = true;
        configs = true;
        plugins = true;
        nvimRuntime = true;
      };
      combinePlugins.enable = true;
    };

    opts = {
      relativenumber = true;
      number = true;
      wrap = false;
      swapfile = false;
      autoindent = true;
      langmap = "чявертъуиопшщасдфгхйклзьцжбнмЧЯВЕРТЪУИОПШЩАСДФГХЙКЛЗѝЦЖБНМ;`qwertyuiop[]asdfghjklzxcvbnm~QWERTYUIOP{}ASDFGHJKLZXCVBNM";
      foldlevel = 99;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
    };

    extraConfigLua = ''
      vim.cmd("syntax on")

      if
        vim.env.SSH_TTY == nil
        and vim.env.SSH_CONNECTION == nil
        and vim.env.SSH_CLIENT == nil
      then
        vim.opt.clipboard = "unnamedplus"
      end

      local colorterm = vim.env.COLORTERM or ""
      local term_program = vim.env.TERM_PROGRAM or ""

      if
        colorterm:find("truecolor") ~= nil
        or colorterm:find("24bit") ~= nil
        or term_program == "WezTerm"
      then
        vim.opt.termguicolors = true
      else
        vim.opt.termguicolors = false
      end

      local function apply_visual_highlight()
        local visual = {
          fg = "#000000",
          bg = "#ffcc00",
          ctermfg = 0,
          ctermbg = 11,
          bold = true,
        }

        vim.api.nvim_set_hl(0, "Visual", visual)
        vim.api.nvim_set_hl(0, "VisualNOS", visual)
      end

      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "UIEnter" }, {
        group = vim.api.nvim_create_augroup("reconciled-visible-visual", { clear = true }),
        callback = apply_visual_highlight,
      })

      apply_visual_highlight()

      vim.api.nvim_create_autocmd("TextYankPost", {
        group = vim.api.nvim_create_augroup("reconciled-yank-highlight", { clear = true }),
        callback = function()
          vim.highlight.on_yank({ timeout = 200 })
        end,
      })

      pcall(vim.keymap.del, "n", "v")
      pcall(vim.keymap.del, "n", "V")
      pcall(vim.keymap.del, "n", "<C-v>")
    '';
  };
}
