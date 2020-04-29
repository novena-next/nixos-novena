{ stdenv
, buildPackages
, fetchFromGitLab
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
    #version = "5.6";
    version = "5.6.0-rc1-next-20200214";    

    # modDirVersion needs to be x.y.z, will automatically add .0 if needed
    modDirVersion = if (modDirVersionArg == null) then concatStrings (intersperse "." (take 3 (splitString "." "${version}.0"))) else modDirVersionArg;

    # branchVersion needs to be x.y
    extraMeta.branch = concatStrings (intersperse "." (take 2 (splitString "." version)));

    src = /etc/nixos/my.tar.gz;

    postInstall = (optionalString (args ? postInstall) args.postInstall) + ''
      mkdir -p "$out/nix-support"
      cp -v "$buildRoot/.config" "$out/nix-support/build.config"
    '';
  } // (args.argsOverride or {}))
)
