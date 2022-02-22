{ landingpage }:
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.home.landingpage;

  mkMagicMergeOption = { description ? "", example ? { }, default ? { }, ... }:
    mkOption {
      inherit example description default;
      type = with lib.types;
        let
          valueType = nullOr
            (oneOf [
              bool
              int
              float
              str
              string
              (attrsOf valueType)
              (listOf valueType)
            ]) // {
            description = "";
            emptyValue.value = { };
          };
        in
        valueType;
    };

in
{

  options.home.landingpage =
    {
      enable = mkEnableOption "landingpage";

      title = mkOption {
        default = "Landing Page (Masonry)";
        type = types.str;
      };
      backgroundColor = mkOption {
        type = types.str;
        default = "#fdf6e3";
      };
      rowTextColor = mkOption {
        type = types.str;
        default = "#fdf6e3";
      };
      rowColor = mkOption {
        type = types.str;
        default = "#6c71c4";
      };
      hoverColor = mkOption {
        type = types.str;
        default = "#268bd2";
      };
      itemColor = mkOption {
        type = types.str;
        default = "#2aa198";
      };
      enableGiphySearch = mkOption {
        type = types.bool;
        default = true;
      };
      enableUrlEncode = mkOption {
        type = types.bool;
        default = true;
      };

      config = mkMagicMergeOption {
        description = "landingpage configuration";
        default = [
          {
            text = "Landing Page (Masonry)";
            items = [
              {
                url = "https://nixos.org/";
                label = "NixOS";
                image = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
              }
            ];
          }
        ];
      };
    };

  config = mkIf cfg.enable {
    home.file."Desktop/landingpage.html".source = "${landingpage.override { jsonConfig =  cfg.config ;
                                                                            colorScheme = {inherit (cfg) backgroundColor rowColor hoverColor itemColor rowTextColor;};
                                                                            inherit (cfg) enableGiphySearch enableUrlEncode;
                                                                          }
                                                    }/index.html";
  };

}
