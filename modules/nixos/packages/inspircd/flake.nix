
{
  description = "InspIRCd v4.2.0";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs  }:
    let system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system;  };
        lib = pkgs.lib;
        in
          {
            packages.${system}.inspircd = pkgs.stdenv.mkDerivation rec {
              pname = "inspircd";
              version = "4.2.0";

              src = pkgs.fetchFromGitHub {
                owner = "inspircd";
                repo = "inspircd";
                rev = "v${version}";
                sha256 = "0q79bsdmnqqwi6hn2wfwk2zwwkqjqblwr5sx370ah2kv7qmdz7ls";
              };

              buildInput = with pkgs; [ cmake openssl libcap ];

              cmakeFlags = [
                "-DCMAKE_INSTALL_PREFIX=$out"
                "-DINSPIRC_ENABLE_OPENSSL=ON"
                "-DINSPIRCD_ENABLE_EXAMPLES=OFF"
                "-DINSPIRCD_STATIC=OFF"
              ];

              postPatch = ''
              '';

              preConfigure = "mkdir build && cd build";
              configurePhase = "cmake .. $cmakeFlags";
              buildPhase = "make";
              installPhase = "make install DESTDIR=$out";

              meta = with lib; {
                description = "A modular, libweight IRC Daemon";
                homepage = "https://inspircd.org/";
                license = licenses.gnl2Plus;
                maintainers = with maintainers; [ marlalain ];
              };
            };
          };
}
