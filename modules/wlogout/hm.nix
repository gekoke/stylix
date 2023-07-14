{ config, lib, pkgs, ... }:
let
  wlogoutOpacity = lib.toHexString ((((builtins.ceil (config.stylix.opacity.desktop * 100)) * 255) / 100));
in {
  options.stylix.targets.wlogout = {
    enable = config.lib.stylix.mkEnableTarget "wlogout" true;
  };

  config = lib.mkIf config.stylix.targets.wlogout.enable {
    # wlogout already inherits its colorscheme from the system's GTK theme
    # for any attributes left undefined in its CSS config, so the following is sufficient:
    programs.wlogout.style = with config.lib.stylix.colors; ''
      window {
          background-image: image(url("${config.stylix.image}"));
          background-size: cover;
          background-color: ${base01-hex}${wlogoutOpacity};
      }

      #lock {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }

      #logout {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }

      #suspend {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
      }

      #shutdown {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }
  '';
  };
}
