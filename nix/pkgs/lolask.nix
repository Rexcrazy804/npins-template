# the cow knows everything
{
  writers,
  cowask,
  lolcat,
}:
writers.writeFishBin "lolask" ''
  ${cowask}/bin/cowask $argv[1] | ${lolcat}/bin/lolcat
''
