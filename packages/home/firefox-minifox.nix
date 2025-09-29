{ 
  stdenv, 
}:

stdenv.mkDerivation {
  name = "minifox";
  src = pkgs.fetchgit {
    url = "https://codeberg.org/awwpotato/MiniFox.git";
    hash = "sha256-I9kIDaqhP5FepTVGcYNLHP+2GQx6K8QdkNXO0KytQFM=";
  };

  phases = ["postFetch"];
  postFetch = ''
    mkdir $out
    cp -r $src/* $out
  '';
}
