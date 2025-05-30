{
  lib,
  stdenv,
  fetchFromGitHub,
  python3,
  runtimeShell,
}:

stdenv.mkDerivation rec {
  pname = "enjarify";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "google";
    repo = "enjarify";
    rev = version;
    sha256 = "sha256-VDBC5n2jWLNJsilX+PV1smL5JeBDj23jYFRwdObXwYs=";
  };

  installPhase = ''
    pypath="$out/${python3.sitePackages}"
    mkdir -p $out/bin $pypath
    mv enjarify $pypath

    cat << EOF > $out/bin/enjarify
    #!${runtimeShell}
    export PYTHONPATH=$pypath
    exec ${python3.interpreter} -O -m enjarify.main "\$@"
    EOF
    chmod +x $out/bin/enjarify
  '';

  meta = with lib; {
    description = "Tool for translating Dalvik bytecode to equivalent Java bytecode";
    homepage = "https://github.com/google/enjarify/";
    license = licenses.asl20;
    maintainers = [ ];
    mainProgram = "enjarify";
  };
}
