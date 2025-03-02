{
  fetchFromGitHub,
  lib,
  stdenvNoCC,
  python3,
  python3Packages,
}:

stdenvNoCC.mkDerivation rec {
  pname = "mint-themes";
  version = "2.2.2";

  src = fetchFromGitHub {
    owner = "linuxmint";
    repo = pname;
    rev = version;
    hash = "sha256-97H2gVSZh0azl2ui4iWsNqgKzkBXRo6Daza2XtRdqII=";
  };

  nativeBuildInputs = [
    python3
    python3Packages.libsass
  ];

  preBuild = ''
    patchShebangs .
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    mv usr/share $out
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/linuxmint/mint-themes";
    description = "Mint-X and Mint-Y themes for the cinnamon desktop";
    license = licenses.gpl3; # from debian/copyright
    platforms = platforms.linux;
    maintainers = teams.cinnamon.members;
  };
}
