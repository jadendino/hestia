#!/bin/bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

if [ $# -eq 0 ]; then
    echo -e "${RED}❌ Usage:${NC} $0 <HOST>"
    echo -e "${YELLOW}Example:${NC} $0 mule"
    exit 1
fi

HOST="$1"

echo -e "${BOLD}${GREEN}🚀 Starting rebuild for host: $HOST${NC}"

if [ ! -f "flake.nix" ]; then
    echo -e "${RED}❌ No flake.nix found in current directory. Ensure you're in the right path.${NC}"
    exit 1
fi

echo -e "${YELLOW}🔧 Running darwin-rebuild switch... (will need sudo permission)${NC}"
sudo \
  NIX_CONFIG="experimental-features = nix-command flakes pipe-operators" \
  darwin-rebuild switch --flake ".#$HOST"

echo -e "${BOLD}${GREEN}🎉 Initial system setup complete for host: $HOST${NC}"
echo -e "${YELLOW}💡 You may need to restart your terminal and log out for changes to be reflected.${NC}"
