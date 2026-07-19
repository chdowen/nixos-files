 { stdenv, lib, dpkg, fetchurl, wayland, libxdamage, libxfixes, libxrandr, libxtst, libxi, libxext, libdrm, libgbm, pulseaudio, libxkbcommon, libxcb-cursor, libxcb-wm, libxcb-image, libxcb-keysyms, libxcb, libxcb-render-util, libxrender, libx11, libGL, dbus, glibc, libgcc, autoPatchelfHook, pkgs
}:

stdenv.mkDerivation rec {
  pname = "ninja-player";
  version = "13.35.8340";
  
  src = fetchurl {
    url = "https://resources.ninjarmm.com/development/ninjacontrol/${version}/ninjarmm-ncplayer-${version}_amd64.deb";
    hash = "sha256-0A5INufc7MyobhloJblMUf85mza0BewiiD9gn1ZhEOg=";
  };
  
  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    
  ];
  
  # sourceRoot = ".";
  unpackPhase = ''
    runHook preUnpack
    
    dpkg-deb -x $src $out
    chmod 755 "$out"
    runHook postUnpack
  '';
  
  # unpackCmd = "dpkg -x ninjarmm-ncplayer-${version}_amd64.deb .";
  
  
  
     
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/applications
    substituteInPlace \
      $out/usr/share/applications/ninjarmm-ncplayer.desktop \
      --replace-warn /opt/ $out/opt/
    #symlink the binary to bin
    ln -s $out/opt/ncplayer/bin/ncplayer $out/share/applications/ncplayer
    mkdir -p $out/share/applications
    
  '';
  
    postInstall = ''
     runHook postInstall
     #!/usr/bin/env bash
     cp ~/myNix/result/usr/share/applications/ninjarmm-ncplayer.desktop ~/.local/share/applications/

    '';
  buildInputs = [
      libxdamage
      libxfixes
      libxrandr
      libxtst
      libxi
      libxext
      libdrm
      libgbm
      pulseaudio
      libxkbcommon
      libxcb-cursor
      libxcb-wm
      libxcb-image
      libxcb-keysyms
      libxcb
      libxcb-render-util
      libxrender
      libx11
      libGL
      dbus
      glibc
      libgcc
      wayland
    ];
    
  meta = with lib; {
    homepage = "https://ninjaone.com";
    description = "NCPlayer for remote connections";
    platforms = platforms.linux;
  };
}
