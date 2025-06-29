{ pkgs, ... }: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
    font-awesome
    fontconfig
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    # Nerd Fonts (corrected)
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.roboto-mono
    nerd-fonts.sauce-code-pro
  ];
}
