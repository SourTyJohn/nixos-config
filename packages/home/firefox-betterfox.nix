{ 
  stdenv,
  fetchFromGitHub, 
}:

stdenv.mkDerivation {
  name = "betterfox";

  src = fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "116.1";
    hash = "sha256-Ai8Szbrk/4FhGhS4r5gA2DqjALFRfQKo2a/TwWCIA6g=";
  };

  phases = ["postFetch"];
  postFetch = ''
    mkdir $out
    cp -r $src/* $out
  '';
}