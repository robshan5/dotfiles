{pkgs, inputs, ...}:
{
  # textfox = {
  #   enable = false;
  #   profile = "lbsfyvsy";
  #   config = {
  #   };    
  # };
  home.file.".mozilla/firefox/i0cfh61j.default/chrome".source = ./chrome;
}
