{ pkgs, ... }:
{
  # Enables Hyprland at the system level. Since this module lives under
  # modules/config-apps and that folder is auto-imported by every system
  # that includes it (desktop, framework, vbox), this one line replaces
  # the separate `programs.hyprland.enable = true;` you previously had
  # duplicated in each system file. Remove those duplicates once this
  # module is wired in, or Nix will just see the same value set twice
  # harmlessly — but it's cleaner to have one source of truth.
  programs.hyprland.enable = true;

  home-manager.sharedModules = [{
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        "$terminal" = "ghostty";
        "$browser" = "firefox";

        general = {
          gaps_in = 4;
          gaps_out = 8;
          border_size = 2;
        };

        bind = [
          # Core
          "$mod, RETURN, exec, $terminal"
          "$mod, Q, killactive"
          "$mod SHIFT, Q, exit"
          "$mod, D, exec, rofi -show drun"      # add pkgs.rofi-wayland if you want this
          "$mod, B, exec, $browser"
          "$mod, V, togglefloating"
          "$mod, F, fullscreen"
          "$mod, L, exec, hyprlock"             # add pkgs.hyprlock if you want this

          # Focus movement (vim-style, matches your nvim/emacs h/j/k/l muscle memory)
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          # Move window
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, J, movewindow, d"

          # Workspaces 1-9
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"

          # Move window to workspace
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"

          # Screenshot (add pkgs.grim + pkgs.slurp if you want this)
          ", Print, exec, grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%s).png"
        ];

        # Mouse-drag bindings
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        # Volume / brightness (laptop + desktop both have media keys)
        bindl = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
      };
    };
  }];
}
