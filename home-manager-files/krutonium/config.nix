{ config, pkgs, ... }:
{
  home.file = {
    ".nanorc".text = ''
      set linenumbers
      set autoindent
      set historylog
      set softwrap
      set tabstospaces
    '';
    ".config/discord/settings.json".text = ''
      {
        "BACKGROUND_COLOR": "#202225",
        "IS_MAXIMIZED": false,
        "IS_MINIMIZED": true,
        "SKIP_HOST_UPDATE: false",
        "WINDOW_BOUNDS": {
          "x": 307,
          "y": 127,
          "width": 1280,
          "height": 725
        }
      }
    '';
    ".config/neofetch/config.conf".text = ''
      print_info() {
        info title
        info underline

        info "OS" distro
        info "Kernel" kernel
        info "Uptime" uptime
        info "CPU" cpu
        info "Memory" memory
        info "GPU" gpu
        info "Resolution" resolution
        info "Shell" shell
        info "Local IP" local_ip
        prin "Weather" "$(curl wttr.in/?0?q?T | awk '/°(C|F)/ {printf $(NF-1) $(NF) " ("a")"} /,/ {a=$0}')"
        info cols
      }
      title_fqdn = "on"
      kernel_shorthand="on"
      distro_shorthand="on"
      os_arch="on"
      uptime_shorthand="on"
      memory_percent="on"
      memory_units="mib"
      package_managers="on"
      shell_path="off"
      shell_version="on"
      speed_type="scaling_max_freq"
      speed_shorthand="off"
      cpu_brand="on"
      cpu_speed="on"
      cpu_cores="logical"
      cpu_temp="on"
      gpu_brand="on"
      gpu_type="all"
      refresh_rate="on"
      gtk_shorthand="on"
      gtk2="on"
      gtk3="on"
      local_ip_interface=('auto')
      de_version="on"
      colors=(distro)
      bold="on"
      underline_enabled="on"
      underline_char="-"
      separator=":"
      block_range=(0 15)
      color_blocks="on"
      block_width=3
      block_height=1
      col_offset="auto"
      bar_char_elapsed="-"
      bar_char_total="="
      bar_border="on"
      bar_length=15
      bar_color_elapsed="distro"
      bar_color_total="distro"
      memory_display="on"
      image_backend="catimg"
      image_source="" #LINK TO IMAGE
      catimg_size="2"
      image_size="auto"
    '';
  };
}
