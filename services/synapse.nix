{ config, pkgs, ... }:
{
  services.matrix-synapse = {
    enable = true;
    database_type = "psycopg2";
    server_name = "krutonium.ca";
    enable_registration = false;
    listeners = [{
      port = 8008;
      bind_address = "0.0.0.0";
      type = "http";
      tls = false;
      resources = [{
        names = [ "client" "federation" ]; #idk what this means
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
