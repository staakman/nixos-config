{ config, lib, pkgs, ... }:

let
  teleportVersion = "15.4.29";
  teleportArchive = "teleport-v${teleportVersion}-linux-amd64-bin.tar.gz";
  teleportUrl = "https://cdn.teleport.dev/${teleportArchive}";

  setupScript = pkgs.writeShellScriptBin "teleport-${teleportVersion}-shell" ''
    set -e
    WORKDIR="$HOME/.teleport-${teleportVersion}"
    mkdir -p "$WORKDIR"
    cd "$WORKDIR"

    if [ ! -f "${teleportArchive}" ]; then
      echo "Downloading Teleport ${teleportVersion}..."
      curl -LO "${teleportUrl}"
      tar -xzf "${teleportArchive}"
    fi

    export PATH="$WORKDIR/teleport:$PATH"
    echo "Teleport ${teleportVersion} ready. Starting shell..."
    exec bash
  '';

  teleportFHS = pkgs.buildFHSUserEnv {
    name = "teleport-${teleportVersion}";
    targetPkgs = pkgs: with pkgs; [ bash coreutils curl gnutar glibc ];
    runScript = "${setupScript}/bin/teleport-${teleportVersion}-shell";
  };

in {
  options.programs.teleport.enable = lib.mkEnableOption "Teleport 15 FHS shell";

  config = lib.mkIf config.programs.teleport.enable {
    home.packages = [ teleportFHS ];
  };
}
