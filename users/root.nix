{ config, pkgs, ... }:
{
  users.users.root = {
    isSystemUser = true;
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwlUAQPu27Tci5RubNf+ybNBif0c5SEBcLV+C2H36TEAddz/A3q8l4Jgfbyg04ycOe8Cldlh5jZVqOiPexoM9pJ+B4oOKmvVEynr30VS5unptPblbOyWIYhj3QtjGT9grzj/3N9W8ACzNhXnMOs0DZwe1ytAWw0BUe5BUbrLcEPKiZvlitZvxUF3Q6/MI7FffUmmpmmccLZXA9chygs3I28vT8YOWfgbegydX1X1zXbDcaV+/m5eJtLAWNLTmFbyL0G5aPBqEKNQg9YitMK0cJqcFaXQEX0bT2jaJdGUJcp3XB50/1D0s727NWPfuqpE+POjhYjuSp64z3/22HyjDK1WyWhTUhTM1PYQogyv6kaIGz8i5qZ5fc5QMHKBAmvXz/dxPywvUtylqOnMlmPmIzezoYuD6okq2altPfEKc3kQ+Ah+tv0XPlxxzh5ID8HZVLP4JV+HCzUoSc8KYKEMUL0GzMmgd1Td16bp70waK3R8uBBDVfjesfqf7vRVS99Ns= krutonium@krutonium-pc" ];
  };
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
}
