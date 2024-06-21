{pkgs}: {
  deps = [
    pkgs.postgresql
    pkgs.libpqxx
    pkgs.libyaml
  ];
}
