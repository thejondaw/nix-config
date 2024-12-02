{ pkgs, ... }: {
  services.flatpak = {
    enable = true;
    packages = [
      "org.mozilla.firefox"
      "org.telegram.desktop"
      "com.discordapp.Discord"
      "com.slack.Slack"
      "com.visualstudio.code"
      "com.github.eovpn.eovpn"
      "org.qbittorrent.qBittorrent"
      "io.github.boxbuddyrs"
    ];
  };
}
