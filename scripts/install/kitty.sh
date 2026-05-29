#!/usr/bin/env bash

# Exit immediately on uncaught errors
set -e

RESET="\e[0m"
BLUE="\e[0;34m"
MAGENTA="\e[0;35m"

# Update sudo cache
sudo -v

PKG="kitty"
PKGFILES="$HOME/.pkgfiles"
STOWDIR="$PKGFILES/stow"
TARGETDIR="/usr/local"
PKGDIR="$STOWDIR/$PKG"

echo -e "${BLUE}Installing package '$PKG'...${RESET}"

if [ ! -d "$PKGDIR" ]; then
  echo -e "${BLUE}Package not found, downloading...${RESET}"
  bash $PKGFILES/scripts/download/kitty.sh
else
  echo -e "${BLUE}Package '$PKG' found, skipping download.${RESET}"
fi

echo -e "${BLUE}Stowing package '$PKG'...${RESET}"
sudo stow -v -d $STOWDIR -t $TARGETDIR $PKG

echo -e "${MAGENTA}Package '$PKG' installed.${RESET}"
