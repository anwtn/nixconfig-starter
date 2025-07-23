25.05 update warnings.

nixconfig-starter on  main [$!] on ☁️  aaron@whatability.com.au(australia-southeast1) took 3s 
❯ sudo nixos-rebuild boot --flake .#
[sudo] password for aaronnewton: 
warning: Git tree '/home/aaronnewton/source/nixconfig-starter' is dirty
building the system configuration...
warning: Git tree '/home/aaronnewton/source/nixconfig-starter' is dirty
evaluation warning: aaronnewton profile: The option `programs.vscode.extensions' defined in `/nix/store/3ckcnb1ldwrrhr4lhyn6hl4bh1yza1fg-source/home/vscode.nix' has been renamed to `programs.vscode.profiles.default.extensions'.
evaluation warning: aaronnewton profile: i18n.inputMethod.enabled will be removed in a future release. Please use .type, and .enable = true instead
evaluation warning: The option `hardware.pulseaudio' defined in `/nix/store/3ckcnb1ldwrrhr4lhyn6hl4bh1yza1fg-source/systems/nixos/configuration.nix' has been renamed to `services.pulseaudio'.
evaluation warning: The option `hardware.opengl.extraPackages' defined in `/nix/store/3ckcnb1ldwrrhr4lhyn6hl4bh1yza1fg-source/systems/nixos/configuration.nix' has been renamed to `hardware.graphics.extraPackages'.
evaluation warning: The option `hardware.opengl.enable' defined in `/nix/store/3ckcnb1ldwrrhr4lhyn6hl4bh1yza1fg-source/systems/nixos/configuration.nix' has been renamed to `hardware.graphics.enable'.
updating systemd-boot from 255.9 to 257.5
Read $KERNEL_INSTALL_LAYOUT from /etc/machine-info. Please move it to the layout= setting of /etc/kernel/install.conf.
Copied "/nix/store/if9z6wmzmb07j63c02mvfkhn1mw1w5p4-systemd-257.5/lib/systemd/boot/efi/systemd-bootx64.efi" to "/boot/efi/EFI/systemd/systemd-bootx64.efi".
Copied "/nix/store/if9z6wmzmb07j63c02mvfkhn1mw1w5p4-systemd-257.5/lib/systemd/boot/efi/systemd-bootx64.efi" to "/boot/efi/EFI/BOOT/BOOTX64.EFI".
Done. The new configuration is /nix/store/s3qzms8z4g353rcpwj1s9vk1kwp7kby1-nixos-system-nixos-25.05.20250626.a676066