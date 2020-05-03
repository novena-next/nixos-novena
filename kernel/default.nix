{ stdenv
, buildPackages
, fetchFromGitHub
, perl
, buildLinux
, modDirVersionArg ? null
, ... } @ args:

let
  inherit (stdenv.lib)
    concatStrings
    intersperse
    take
    splitString
    optionalString
  ;
in
(
  buildLinux (args // rec {
    version = "5.7.0-rc2";
    #version = "5.6.0-rc1-next-20200214";

    # branchVersion needs to be x.y
    extraMeta.branch = concatStrings (intersperse "." (take 2 (splitString "." version)));

    # nix-prefetch-git  https://github.com/novena-next/linux --rev refs/heads/nvn_v5.7-rc2
    src = fetchFromGitHub {
      owner = "novena-next";
      repo = "linux";
      rev = "nvn_v5.7-rc2";
      sha256 = "0hhgw5lb3zzyvxry1zk68367bza6k6d9jq5af5mjmjizw8bd9zdm";
    };

    postInstall = (optionalString (args ? postInstall) args.postInstall) + ''
      mkdir -p "$out/nix-support"
      cp -v "$buildRoot/.config" "$out/nix-support/build.config"
    '';

    extraConfig = ''
      REGULATOR_PFUZE100 y

      DRM_ETNAVIV y
      DRM_ETNAVIV_THERMAL y
      DRM_ITE_IT6251 y

      NET_ETHERNET m
      USB_USBNET m
      USB_NET_AX8817X m
      SND_SOC_IMX_ES8328 m

      USB_SERIAL_PL2303 m
      USB_SERIAL_CH341 m
    '';

  } // (args.argsOverride or {}))
)
