{ config, lib, pkgs, ... }:

{
  home.username = "daimyo";
  home.homeDirectory = "/home/daimyo";
  home.stateVersion = "25.05";
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Install packages
  home.packages = with pkgs; [
    # Development tools
    warp-terminal
    zed-editor
    gh        # GitHub CLI tool
    git       # Git version control
    lazygit   # Terminal UI for git

    # System utilities
    btop

    # Note: neovim and yazi are configured through programs below
  ];

  # Enable programs with configuration
  programs.home-manager.enable = true;

  # Basic neovim configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaConfig = with pkgs.vimPlugins;
      # lua
      ''
        require("lazy").setup({
          -- ...
          spec = {
            {
              -- since we used `with pkgs.vimPlugins` this will expand to the correct path
              dir = "${nvim-cmp}",
              name = "nvim-cmp",
              event = { "InsertEnter", "CmdlineEnter" },
              dependencies = {
                -- we can also load dependencies from a local folder
                { dir = "${cmp-nvim-lsp}", name = "cmp-nvim-lsp" },
                { dir = "${cmp-path}", name = "cmp-path" },
                { dir = "${cmp-buffer}", name = "cmp-buffer" },
                { dir = "${cmp-cmdline}", name = "cmp-cmdline" },
              },
              config = function ()
                local cmp = require('cmp')

                cmp.setup({
                  sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                  }),
                  snippet = {
                    expand = function(args)
                      vim.snippet.expand(args.body)
                    end,
                  },
                  mapping = cmp.mapping.preset.insert({}),
                })

                -- Use buffer source for `/` and `?`
                cmp.setup.cmdline({ '/', '?' }, {
                  mapping = cmp.mapping.preset.cmdline(),
                  sources = {
                    { name = 'buffer' },
                  },
                })

                -- Use cmdline & path source for ':'
                cmp.setup.cmdline(':', {
                  mapping = cmp.mapping.preset.cmdline(),
                  sources = cmp.config.sources({
                    { name = 'path' },
                  }, {
                    { name = 'cmdline' },
                  }),
                  matching = { disallow_symbol_nonprefix_matching = false },
                })
              end,
            },
          },
        })
      '';
  };

  # Yazi configuration
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "daimyo";
    userEmail = "your-email@example.com"; # Update this
  };

  # Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
}
