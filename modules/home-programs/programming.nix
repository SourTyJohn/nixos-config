{
  config,
  pkgs,
  ...
}:
let
  vscodeUserSettings = {
    "editor.letterSpacing" = 0.1;
    "editor.fontSize" = 14;
    "terminal.integrated.gpuAcceleration" = "on";
    "gitlens.hovers.annotations.details" = false;
    "explorer.fileNesting.expand" = false;
    "explorer.compactFolders" = false;
    "explorer.autoReveal" = false;

    "python.analysis.typeCheckingMode" = "standard";
    "ruff.enable" = true;
    "ruff.lineLength" = 79;
    "ruff.lint.enable" = true;
    "[python]" = {
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "charliermarsh.ruff";
      "editor.codeActionsOnSave" = {
          "source.fixAll" = "explicit";
      };
    };

    "files.exclude" = {
        "/.git" = true;
        "pycache" = true;
        "**/__pycache__" = true;
        "typings" = false;
        ".idea" = true;
        "common" = false;
    };
  };
in
{
  config = {
    # Packages for programming
    home.packages = with pkgs; [
      # python
      python3
      # python312

      # web-development
      docker
      putty
      redis

      # php
      php

      # do not remove
      git

      # java
      jdk
      spring-boot-cli
    ];

    programs = {
      # Install and configure vscode
      vscode = {
        enable = true;

        profiles = {
          default = {
            extensions = with pkgs.vscode-extensions; [
              # nix lang support
              jnoortheen.nix-ide
              arrterian.nix-env-selector
              mkhl.direnv
              # python
              ms-python.python
              ms-python.vscode-pylance
              charliermarsh.ruff
              # html
              ecmel.vscode-html-css
              # general
              ms-azuretools.vscode-docker
              mhutchie.git-graph
              github.vscode-github-actions
            ];
            userSettings = vscodeUserSettings;
          };

          golang = {
            extensions = with pkgs.vscode-extensions; [
              # golang
              golang.go
              # html
              ecmel.vscode-html-css
              # general
              ms-azuretools.vscode-docker
              mhutchie.git-graph
              github.vscode-github-actions
            ];
            userSettings = vscodeUserSettings;
          };
        };
      };
        # Git
      git = {
        enable = true;
        userName = "SourTyJohn";
        userEmail = "mr.ukhov@list.ru";
      };
    };
  };
}
