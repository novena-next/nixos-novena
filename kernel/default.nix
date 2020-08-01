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

    ignoreConfigErrors = true;
    #version = "5.6.0-rc1-next-20200214";

    # branchVersion needs to be x.y
    extraMeta.branch = concatStrings (intersperse "." (take 2 (splitString "." version)));

    # nix-prefetch-git  https://github.com/novena-next/linux --rev refs/heads/nvn_v5.7-rc2
    src = fetchFromGitHub {
      owner = "novena-next";
      repo = "linux";
      rev = "nvn_v5.7-rc2";
      sha256 = "1nfy5ywj1w9ibary8aamywksvwab84rlpsvz9r5v7lbd0y6bqcdg";
    };

    postInstall = (optionalString (args ? postInstall) args.postInstall) + ''
      mkdir -p "$out/nix-support"
      cp -v "$buildRoot/.config" "$out/nix-support/build.config"
    '';

  } // (args.argsOverride or {}))
)
