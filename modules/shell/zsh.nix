{ lib, pkgs, ... }:
let
  inherit (lib) enabled;

  package = pkgs.zsh;
in {
  home-manager.sharedModules = [(homeArgs: let
    config' = homeArgs.config;
  in {
    programs.zsh = enabled {
      inherit package;

      dotDir = "${config'.xdg.configHome}/zsh";
      #shellAliases = config.environment.shellAliases
      #  |> filterAttrs (_: value: value != null);


      enableCompletion = true;

      sessionVariables = {
        EDITOR = "hx";
        TERMINAL = "ghostty";
        PAGER = "nvim +Man!";
        HOMEBREW_NO_ANALYTICS = 1;
        HOMEBREW_NO_ENV_HINTS = 1;
      };

      history = {
        extended = true;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        path = "${config'.xdg.stateHome}/zsh/history";
        save = 20000;
        share = true;
        size = 20000;
      };

      # Additional .zshrc content (initExtra)
      initContent = ''
        ### completion settings
        setopt globdots
        setopt menu_complete
        setopt list_rows_first

        zstyle ':completion:*' menu select

        ### history setup
        if [[ "$(uname -s)" == "Darwin" ]]; then
          # disable Apple's "save/restore shell state" feature
          # see /etc/zshrc_Apple_Terminal
          SHELL_SESSIONS_DISABLE=1
        fi

        if [ ! -d "$XDG_STATE_HOME/zsh" ]; then
          mkdir -p "$XDG_STATE_HOME/zsh"
        fi

        setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
        setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
        setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
        setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
        setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
        setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
        setopt SHARE_HISTORY             # Share history between all sessions.
        
        # Disable Apple's shell sessions on macOS
        if [[ "$(uname -s)" == "Darwin" ]]; then
          SHELL_SESSIONS_DISABLE=1
        fi

        # Utility function for timing zsh startup
        timezsh() { repeat 10 { time zsh -i -c exit } }

        # Preview function for m3u8 streams
        preview() {
            local url="$1"
            if [ -z "$url" ]; then
                echo "Usage: preview <m3u8_url>"
                return 1
            fi

            # Use ffprobe to get video metadata (duration, width, height)
            local metadata=$(ffprobe -v error -select_streams v:0 \
                -show_entries format=duration:stream=width,height \
                -of default=noprint_wrappers=1:nokey=1 "$url" 2>/dev/null)

            # Parse metadata (assuming order: duration, width, height)
            local duration_sec=$(echo "$metadata" | sed -n '1p')
            local width=$(echo "$metadata" | sed -n '2p')
            local height=$(echo "$metadata" | sed -n '3p')

            duration_sec=''${duration_sec%.*}  # Truncate to integer if needed

            # Calculate random seek time if duration is available and positive, else 0
            local seek_time=0
            if [ -n "$duration_sec" ] && [ "$duration_sec" -gt 0 ]; then
               seek_time=$(awk -v d="$duration_sec" 'BEGIN {srand(); print int(rand() * d)}')
            fi

            # Create a temporary file for the frame
            local tmp=$(mktemp /tmp/preview-m3u8.png)

            # Extract one frame using ffmpeg at the random seek time
            ffmpeg -ss "$seek_time" -i "$url" -vframes 1 -y "$tmp" > /dev/null 2>&1

            if [ ! -s "$tmp" ]; then
                echo "Failed to extract frame."
                rm -f "$tmp"
                return 1
            fi

            # Print relevant metadata (dimensions primarily, plus duration if available)
            echo "Preview Metadata:"
            if [ -n "$width" ] && [ -n "$height" ]; then
                echo "  Dimensions: ''${width}x''${height}"
            else
                echo "  Dimensions: Not available"
            fi
            if [ -n "$duration_sec" ] && [ "$duration_sec" -gt 0 ]; then
                echo "  Duration: $duration_sec seconds"
            else
                echo "  Duration: Not available (e.g., live stream)"
            fi

            # Open the frame in mpv (mpv can display images; quits on keypress or close)
            mpv "$tmp" --osc=no --loop-file=inf > /dev/null 2>&1

            # Delete the temporary file after mpv closes
            rm -f "$tmp"
        }

        # Download function using yt-dlp
        grab() {
          yt-dlp \
            -f "bestvideo+bestaudio/best" \
            --remux-video mkv \
            --all-subs \
            --embed-subs \
            -o "''${2}.%(ext)s" \
            "''${1}"
        }

        # Default prompt
        PS1="%n@%m %1~ %# "
      '';

      # .zprofile content
      profileExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';

      shellAliases = {
        ls = "eza -a --group-directories-first --color=auto";
      };

      # Additional .zshenv content (for XDG defaults, to retain functionality on base macOS)
      envExtra = ''
        export XDG_CONFIG_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}"
        export XDG_DATA_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}"
        export XDG_STATE_HOME="''${XDG_STATE_HOME:-$HOME/.local/state}"
        export XDG_CACHE_HOME="''${XDG_CACHE_HOME:-$HOME/.cache}"
      '';
    };
  })];
}
