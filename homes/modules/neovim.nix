{ lib, config, pkgs, inputs, ... }:

let
  harperUserDict = [
    "Atanas"
    "Dimitrov"
  ];
  vi_action = action: "<CMD>${action}<CR>";
  lua_action = action: "<CMD>lua ${action}<CR>";
  default_km_opts = {
    remap = false;
    silent = true;
  };
in
  {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.file.".config/harper-ls/user.dict".text = lib.concatStringsSep "\n" harperUserDict;

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    globals.mapleader = " ";
    globals.maplocalleader = " ";

    plugins = {
      lean = {
        enable = true;
      };

      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
          incremental_selection.enable = true;
          indent.enable = true;
        };
      };

      lsp = {
        enable = true;

        servers = {
          ruff.enable = true;
          pyright = {
            enable = true;
            settings = {
              pyright.disableOrganizeImports = true;
              python.analysis.ignore = [ "*" ];
            };
          };
          nil_ls = {
            enable = true;
            settings.nix.flake.autoArchive = true;
          };
          clangd.enable = true;
          ocamllsp.enable = true;

          harper_ls = {
            enable = true;
            settings = {
              "harper-ls" = {
                userDictPath = "${config.home.homeDirectory}/.config/harper-ls/user.dict";
                workspaceDictPath = "";
                fileDictPath = "";
                linters = {
                  SpellCheck = true;
                  SpelledNumbers = false;
                  AnA = true;
                  SentenceCapitalization = true;
                  UnclosedQuotes = true;
                  WrongQuotes = false;
                  LongSentences = true;
                  RepeatedWords = true;
                  Spaces = true;
                  Matcher = true;
                  CorrectNumberSuffix = true;
                };
                codeActions = {
                  ForceStable = false;
                };
                markdown = {
                  IgnoreLinkTitle = false;
                };
                diagnosticSeverity = "hint";
                isolateEnglish = false;
                dialect = "American";
                maxFileLength = 120000;
              };
            };
          };
        };

        keymaps = {
          silent = true;

          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gi" = "implementation";
            "gr" = "references";
            "ca" = "code_action";
            "ff" = "format";
            "K" = "hover";
          };
        };
      };

      telescope = {
        enable = true;
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

      web-devicons.enable = true;
      guess-indent.enable = true;
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
        key = "<SPACE>lf";
        action = lua_action "vim.lsp.buf.code_action()";
        options = default_km_opts;
      }
      {
        key = "<SPACE>tf"; # telescope-file
        action = vi_action "Telescope git_files";
        options = default_km_opts;
      }
      {
        key = "<SPACE>tg"; # telescope-grep
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
      clipboard = "unnamedplus";
      wrap = false;
      swapfile = false;
      autoindent = true;
      langmap = "чявертъуиопшщасдфгхйклзьцжбнмЧЯВЕРТЪУИОПШЩАСДФГХЙКЛЗѝЦЖБНМ;`qwertyuiop[]asdfghjklzxcvbnm~QWERTYUIOP{}ASDFGHJKLZXCVBNM";
      foldlevel = 99;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
    };
  };
}
