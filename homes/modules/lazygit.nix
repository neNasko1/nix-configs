{ lib, config, pkgs, ... }:

{
  home.packages = [ pkgs.delta ];

  programs.lazygit = {
    enable = true;

    settings = {
      os = {
        editPreset = "nvim";
      };

      gui = {
        sidePanels = [
          [ "commits" "reflog" ]
          [ "files" "worktrees" "submodules" ]
          [ "stash" "branches" ]
        ];
        sidePanelWidth = 0.25;
        expandFocusedSidePanel = true;
        skipDiscardChangeWarning = true;
        skipStashWarning = true;
        skipNoStagedFilesWarning = true;
        skipRewordInEditorWarning = true;
        skipAmendWarning = true;
        skipSwitchWorktreeOnCheckoutWarning = true;
        showFileTree = false;
      };

      git = {
        diffRenderers = [
          { command = "delta --dark --paging=never"; }
          {
            type = "rawGit";
            args = [ "--color-words" ];
            name = "color-words";
          }
        ];
      };

      quitOnTopLevelReturn = true;
      disableStartupPopups = true;
      promptToReturnFromSubprocess = false;
      notARepository = "skip";
    };
  };
}
