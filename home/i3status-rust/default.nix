{
  pkgs,
  config,
  ...
}: {
  imports = [
  ];
  home.file = {
    "${config.xdg.configHome}/i3status-rust".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/wks/nixconfig-starter/home/i3status-rust/config";
  };
  home.packages = with pkgs.unstable; [
    i3status-rust
  ];
}
