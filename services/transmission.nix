{ config, pkgs, lib, ... }:
let
    peerPort = 50023;
in {
    services.transmission = {
        enable = true;
        downloadDirPermissions = "777";
        settings = {
            /* directory settings */
            "watch-dir" = "/transmission/Watch";
            "watch-dir-enabled" = true;
            "download-dir" = "/transmission/Completed-Downloads";
            "incomplete-dir" = "/transmission/Incomplete-Downloads";
            "incomplete-dir-enabled" = false;

            /* web interface, accessible from local network */
            "rpc-enabled" = true;
            "rpc-bind-address" = "0.0.0.0";
            "rpc-whitelist" = "127.0.0.1,192.168.*.*";
            "rpc-host-whitelist" = "void,192.168.*.*";
            "rpc-host-whitelist-enabled" = true;

            "port-forwarding-enabled" = true;
            "peer-port" = peerPort;
            "peer-port-random-on-start" = false;

            "encryption" = 1;
            "lpd-enabled" = false; /* local peer discovery */
            "dht-enabled" = false; /* dht peer discovery in swarm */
            "pex-enabled" = false; /* peer exchange */

            /* ip blocklist */
            "blocklist-enabled" = false;
            "blocklist-updates-enabled" = false;
            "blocklist-url" = "";

            /* download speed settings */
            "speed-limit-down" = 1200;
            "speed-limit-down-enabled" = false;
            "speed-limit-up" = 2000;
            "speed-limit-up-enabled" = true;

            /* seeding limit */
            "ratio-limit" = 10;
            "ratio-limit-enabled" = true;
        };
    };
}