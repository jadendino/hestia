#!/bin/bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='⠏⠇⠧⠦⠴⠼⠸⠹⠙⠋'
    while kill -0 "$pid" 2>/dev/null; do
        for i in $(seq 0 ${#spinstr}); do
            printf "\r${YELLOW}${spinstr:$i:1}${NC} $2"
            sleep "$delay"
        done
    done
    wait "$pid"
    if [ $? -eq 0 ]; then
        printf "\r${GREEN}✅${NC} $2 ${GREEN}Done!${NC}\n"
    else
        printf "\r${RED}❌${NC} $2 ${RED}Failed!${NC}\n"
    fi
}

if [ $# -eq 0 ]; then
    echo -e "${RED}❌ Usage:${NC} $0 <HOST>"
    echo -e "${YELLOW}Example:${NC} $0 mule"
    exit 1
fi

HOST="$1"

echo -e "${BOLD}${GREEN}🚀 Starting initial system setup for host: $HOST${NC}"

if ! command -v nix &>/dev/null; then
    echo -e "${YELLOW}⚠️ Nix is not installed.${NC}"
    echo "Please download and install Nix using the graphical installer from:"
    echo "https://github.com/DeterminateSystems/nix-installer"
    echo ""
    echo -e "${YELLOW}After installing Nix, restart your terminal and re-run this script.${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Nix already installed${NC}"
fi

if ! command -v brew &>/dev/null; then
    echo -e "${YELLOW}📦 Installing Homebrew...${NC}"
    read -p "Proceed? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}❌ Installation aborted.${NC}"
        exit 1
    fi
    if ! command -v curl &>/dev/null; then
        echo -e "${RED}❌ curl is required but not found. Install it manually.${NC}"
        exit 1
    fi
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &
    spinner $! "Installing Homebrew"
    
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo -e "${GREEN}✅ Homebrew already installed${NC}"
fi

if [ ! -f "flake.nix" ]; then
    echo -e "${RED}❌ No flake.nix found in current directory. Ensure you're in the right path.${NC}"
    exit 1
fi

echo -e "${YELLOW}🔧 Running darwin-rebuild switch... (will need sudo permission)${NC}"
sudo nix run nix-darwin -- switch --flake ".#$HOST"

echo -e "${BOLD}${GREEN}🎉 Initial system setup complete for host: $HOST${NC}"
echo -e "${YELLOW}💡 You may need to restart your terminal or source your shell configuration.${NC}"
