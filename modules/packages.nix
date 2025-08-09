{ pkgs, ... }: {
  unfree.allowedNames = [ "claude-code" ];
  
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
    nil
    ffmpeg
    yt-dlp
    claude-code
  ];
}
