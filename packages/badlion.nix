# If someone wants to upstream this, I would appreciate it
{pkgs, config, fetchurl, appimageTools, ...}:
let
  pname = "Badlion Client";
  version = "1.18.2";

  # I'd use their website's normal URL but they gate getting new URL's by cookies.
  src = fetchurl {
    url = "https://client-updates-cdn77.badlion.net/BadlionClient";
    sha256 = "0ixngc740nxdlqhkykfqyk6b5ypmk0bhp601z5ycnf5xp9mrmccf";
  };
  appimageContents = appimageTools.extractType2 { inherit name src; };
in
{
  
}