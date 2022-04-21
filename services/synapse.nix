{ config, pkgs, ... }:
{
  services.matrix-synapse = {
    enable = true;
    settings.database_name = "psycopg2";
    settings.server_name = "krutonium.ca";
    settings.enable_registration = false;
    settings.max_upload_size = "50M";
    settings.listeners = [{
      port = 8008;
      bind_addresses = ["127.0.0.1"]; # only local, handled by nginx reverse-proxy
      type = "http";
      tls = false;
      x_forwarded = true;
      resources = [{
        names = [ "client" "federation" ];
        compress = false;
      }];
    }];
  };
  services.postgresql = {
    enable = true;
    initialScript = pkgs.writeText "synapse-init.sql" ''
      CREATE ROLE "matrix-synapse" WITH LOGIN PASSWORD 'synapse';
      CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
      TEMPLATE template0
      LC_COLLATE = "C"
      LC_CTYPE = "C";
    '';
  };
}
