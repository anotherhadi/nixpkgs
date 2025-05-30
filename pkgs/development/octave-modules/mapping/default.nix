{
  buildOctavePackage,
  lib,
  fetchurl,
  io, # >= 2.2.7
  geometry, # >= 4.0.0
  gdal,
}:

buildOctavePackage rec {
  pname = "mapping";
  version = "1.4.2";

  src = fetchurl {
    url = "mirror://sourceforge/octave/${pname}-${version}.tar.gz";
    sha256 = "sha256-mrUQWqC15Ul5AHDvhMlNStqIMG2Zxa+hB2vDyeizLaI=";
  };

  buildInputs = [
    gdal
  ];

  requiredOctavePackages = [
    io
    geometry
  ];

  meta = {
    homepage = "https://gnu-octave.github.io/packages/mapping/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ KarlJoad ];
    description = "Simple mapping and GIS .shp .dxf and raster file functions";
  };
}
