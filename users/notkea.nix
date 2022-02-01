{ lib, config, ... }:

{
  users.users.kea = {
    isNormalUser = true;
    uid = 800;  # less than 1000 not to show up in login manager
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZaIK7NUUlJRaxVCnRc3Bq78aVw9LRd2zDNGKQMixuW kea@WARFSTATION"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIElh2sqH+6bZWIDBL5haoTn0VPuFmHoROpernmr7Jrao kea@TWIST"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEOOQoLq0Ao5GuNSWDbxPuL/qYCTlaLL62BnyM/K+Xlt kea@BOX"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA+EnBu0D+Nh20+Hyp90H96p4q5SsMZupHNH71v0NJUt kea@PASCIENCE"
    ];
  };
}
