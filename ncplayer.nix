 { stdenv, lib, dpkg, fetchurl, libxdamage, libxfixes, libxrandr, libxtst, libxi, libxext, libdrm, libgbm, pulseaudio, libxkbcommon, libxcb-cursor, libxcb-wm, libxcb-image, libxcb-keysyms, libxcb, libxcb-render-util, libxrender, libx11, libGL, dbus, glibc, libgcc, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "ninja-player";
  version = "11.35.7720";

  src = fetchurl {
    url = "https://resources.ninjarmm.com/development/ninjacontrol/${version}/ninjarmm-ncplayer-${version}_amd64.deb";
    hash = "sha256-VEroAcOIZJSONC1wGsQDzDUkgCt5taFCS0ghyopiO00=";
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
    mkdir -p $out/bin
    substituteInPlace \
      $out/usr/share/applications/ninjarmm-ncplayer.desktop \
      --replace /opt/ $out/opt/
    #symlink the binary to bin
    ln -s $out/opt/ncplayer/bin/ncplayer $out/bin/ncplayer
    
    runHook postInstall
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
    ];
    
  meta = with lib; {
    homepage = "https://ninjaone.com";
    description = "NCPlayer for remote connections";
    platforms = platforms.linux;
  };
}
