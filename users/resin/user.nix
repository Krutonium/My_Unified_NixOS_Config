{ config, ... }:
{
  users.users.resin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys =
      [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNTOdm2DReY6s6lPx+jWsvks2I/zJ3AeP6YfrdP01I9k15+tAHmmadiaC+ogUGLfeAzb8X0xfMGUm4feKCAXsfx649DO794ebv+GDLLfZzV6Q/PlZ5fsHbOGZoc5K3zyDpDQv0OK7hB8KX36rw1z9HHpI9Rp4/ToJ/pRNlCvsG49qxYpF0T76LANdWKLSPcqf5t22B5ypm/30+/OvYl0ZvB1bGtHeNFFkPFQHhUT6v3fAd7LM+M/qkLigzAyC5Or3lByN5t1QlLNyZwREIuDVPZHmGm8DJyRm7qrbgl3+7bJBhFzRNjYlCVCJQFNb5eD2qX3NoIi1i+7eElL40ahdhKq8KkHP+zhb4G9G7we8Aght0vQagRZyRcZpGTXqq6rbQfChVqSjhEPgp/DBlOJVG5qrRU7Z8kt2tiUfcEnmaKXs83Rfj6tgTdT+Ys7GSQ2VJjGO76Zw8SSZWfOTD1D8Lfr3MioBWz0x4+gqUDnp6oFslV2QhzeXDs74c0HylLzc= resin@resindrake"
      ];
  };
}
