{ config, pkgs, ... }:
{
  services.matrix-synapse = {
    enabled = true;
    config.bindAddress = "192.168.0.10";
    config.bindPort = "8008";
  };
}