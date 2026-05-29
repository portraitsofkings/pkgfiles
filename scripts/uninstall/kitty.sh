#!/usr/bin/env bash

PKGFILES="$HOME/.pkgfiles"
# source $PKGFILES/scripts/lib/shared.sh

# Exit immediately on uncaught errors
set -e

# Update sudo cache
sudo -v

PKG="kitty"
STOWDIR="$PKGFILES/stow"
TARGETDIR="/usr/local"
PKGDIR="$STOWDIR/$PKG"

echo -e "${BLUE}Uninstalling package '$PKG'...${RESET}"
if [ -d "$PKGDIR" ]; then
  echo -e "${BLUE}Unstowing package '$PKG'...${RESET}"
  sudo stow -v -d $STOWDIR -t $TARGETDIR -D $PKG

  echo -e "${BLUE}Removing stow/$PKG...${RESET}"
  rm -rf $PKGDIR
else
  echo -e "${RED}[ERROR] Attempted to uninstall non-existent package '$PKG'.${RESET}"
  exit 1
fi

echo -e "${MAGENTA}Package '$PKG' uninstalled.${RESET}"
