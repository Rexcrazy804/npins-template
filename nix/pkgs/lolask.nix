# the cow knows everything
{
  writers,
  cowask,
  lolcat,
}:
writers.writeFishBin "lolask" ''
  ${cowask}/bin/cowask $argv | ${lolcat}/bin/lolcat
''
