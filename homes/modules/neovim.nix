{ lib, config, pkgs, inputs, ... }:

let 
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

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    globals.mapleader = " ";
    globals.maplocalleader = " ";

    plugins = {
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
          nil-ls.enable = true;
          ccls.enable = true;
          ocamllsp.enable = true;
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

      web-devicons.enable = true;
      guess-indent.enable = true;

      chatgpt = {
        enable = true;

        settings = {
          api_key_cmd = "cat ~/my-nix/secrets/openai.txt";
          openai_params = {
            model = "gpt-4-1106-preview";
            max_tokens = 4095;
          };
          openai_edit_params = {
            model = "code-davinci-edit-001";
          };
          keymaps = {
            close = [ "<C-c>" ];
            submit = "<C-s>";
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
      byteCompileLua.enable = true;
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
    };
  }; 
}
