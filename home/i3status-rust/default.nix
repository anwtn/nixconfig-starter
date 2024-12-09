{
  pkgs,
  config,
  ...
}: {
  imports = [
  ];
  home.file = {
    "${config.xdg.configHome}/i3status-rust".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/source/nixconfig-starter/home/i3status-rust/config";
  };
  home.packages = with pkgs; [
    i3status-rust
  ];
}
