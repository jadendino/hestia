{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    eza
    fd
    fzf
    git
    hyperfine
    mpv
    neovim
    openconnect
    ripgrep
    ruff
    tectonic
    texlab
    uv
    yazi
    zoxide
    nil
    ffmpeg
    yt-dlp
  ];
}
