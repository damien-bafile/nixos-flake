{ pkgs, ... }:
{
  # System package
  environment.systemPackages = [ pkgs.neovim ];

  # User configuration (LazyVim bootstrap)
  home-manager.sharedModules = [{
    xdg.configFile."nvim/init.lua".text = ''
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable",
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      require("lazy").setup({
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        -- add your plugins here
      }, {
        defaults = { lazy = true, version = "*" },
      })
    '';
  }];
}
