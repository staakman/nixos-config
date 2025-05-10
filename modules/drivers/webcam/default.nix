{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = [ pkgs.v4l-utils ];

    systemd.services.webcam-format-fix = {
      description = "Fix webcam pink output by setting correct video format";
      after = [ "basic.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.v4l-utils}/bin/v4l2-ctl -d /dev/video0 --set-fmt-video=width=640,height=480,pixelformat=YUYV";
      };
    };
  };
}
