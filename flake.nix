# lets you initialize the template fairly easily with
# nix flake new proj -t github:Rexcrazy804/npins-template
{
  outputs = _: {
    templates.default = {
      path = ./.;
      descprition = "An elegant flake like npins template";
      welcomeText = ''
        # Rexiel's npins template
        See the justfile for common commands to build
        and use the default.nix.
      '';
    };
  };
}
