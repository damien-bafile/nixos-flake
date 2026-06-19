# Auto‑import all subdirectories that contain a default.nix.
# Wrapped as a proper module (not a bare list) so it can be used directly
# in a system's `imports`.
{ ... }:
let
  entries = builtins.readDir ./.;
  dirs = builtins.filter
    (name:
      entries.${name} == "directory" &&
      builtins.pathExists (./. + "/${name}/default.nix")
    )
    (builtins.attrNames entries);
in
{
  imports = map (name: ./. + "/${name}") dirs;
}
