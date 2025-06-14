{
  config,
  pkgs,
  lib,
  ...
}:
let
  fromGitHub =
    owner: repo: ref: hash:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = pkgs.fetchFromGitHub {
        owner = owner;
        repo = repo;
        rev = ref;
        sha256 = hash;
      };
    };

in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      # ui
      gruvbox-nvim
      nvim-web-devicons
      nvim-notify
      lualine-nvim
      dressing-nvim

      # basics
      indent-blankline-nvim
      gitsigns-nvim
      todo-comments-nvim
      ts-comments-nvim
      harpoon2
      vim-fugitive
      vim-flog
      vim-rhubarb
      vim-abolish
      vim-repeat
      vim-eunuch
      vim-sleuth
      vim-speeddating
      telescope-nvim
      telescope-github-nvim
      auto-hlsearch-nvim
      vim-tmux-navigator
      bufdelete-nvim
      nvim-colorizer-lua
      vim-exchange

      (fromGitHub "akinsho" "git-conflict.nvim" "main"
        "sha256-CmSgmpg5K3ySXYrDjg8yTAojeLWJdSHP8uNVFyrkNhc="
      )

      # ai
      copilot-lua

      # coding
      nvim-lspconfig
      conform-nvim
      blink-cmp
      blink-cmp-copilot
      nvim-autopairs
      nvim-ts-autotag
      friendly-snippets
      lazydev-nvim
      neogen
      nvim-surround
      treesj
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (
        plugins: with plugins; [
          arduino
          awk
          bash
          cpp
          css
          csv
          diff
          dockerfile
          fish
          git_config
          git_rebase
          gitattributes
          gitcommit
          gitignore
          go
          gomod
          gosum
          gowork
          graphql
          hcl
          html
          http
          http
          ini
          javascript
          jq
          json
          lua
          make
          markdown
          markdown_inline
          mermaid
          nix
          python
          query
          regex
          ruby
          scss
          sql
          ssh_config
          templ
          terraform
          toml
          vhs
          vim
          vimdoc
          yaml
          zig
        ]
      ))
      nvim-treesitter-textobjects
      nvim-treesitter-context
      nvim-treesitter-endwise
      other-nvim
      hmts-nvim # treesitter injections for home-manager

      # sql
      vim-dadbod
      vim-dadbod-ui
      vim-dadbod-completion
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };
}
