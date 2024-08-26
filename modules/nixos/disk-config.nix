_: {
  disko.devices = {
    disk = {
      vdb = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "100M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "soiree";
              };
            };
          };
        };
      };
    };
    zpool = {
      soiree = {
        type = "zpool";
        rootFsOptions = {
          compression = "zstd";
          atime = "off";
        };
        mountpoint = "/";
        datasets = {
          encrypted = {
            options = {
              mountpoint = "none";
              encryption = "aes-256-gcm";
              keyformat = "passphrase";
            };
          };
          nix = { options = { mountpoint = "/nix"; }; };
          home = { options = { mountpoint = "/home"; }; };
          var = { options = { mountpoint = "/var"; }; };
        };
      };
    };
  };
}
