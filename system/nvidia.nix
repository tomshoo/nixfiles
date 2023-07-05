{ pkgs,
  config,
  ...
}: let
  prime-offload = pkgs.writeShellScriptBin "prime-offload"
    ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
    '';
in {
  environment.systemPackages    = [ prime-offload ];
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware =
    { opengl =
        { enable     = true;
          driSupport = true;
        };

      nvidia =
        { package                = config.boot.kernelPackages.nvidiaPackages.stable;
          modesetting.enable     = true;
          powerManagement.enable = true;

          prime =
            { offload.enable = true;
              intelBusId     = "PCI:00:02:0";
              nvidiaBusId    = "PCI:01:00:0";
            };
        };
    };
}
