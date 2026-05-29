#!/usr/bin/env bash

# Exit immediately on uncaught errors
set -e

RESET="\e[0m"
BLUE="\e[0;34m"
MAGENTA="\e[0;35m"

PKG="kitty"
PKGFILES="$HOME/.pkgfiles"
STOWDIR="$PKGFILES/stow"
PKGDIR="$STOWDIR/$PKG"

VERSION="0.47.1"
ARCHITECTURE="x86_64"
FILE="kitty-${VERSION}-${ARCHITECTURE}.txz"
URL="https://github.com/kovidgoyal/kitty/releases/download/v${VERSION}/$FILE"

if [ -d "$PKGDIR" ]; then
  echo -e "${BLUE}Removing old package files...${RESET}"
  rm -rf $PKGDIR
fi

echo -e "${BLUE}Creating package directory structure...${RESET}"
mkdir -p $PKGDIR

# echo -e "${BLUE}Creating a temporary file...${RESET}"
TEMP_FILE=$(mktemp)

echo -e "${BLUE}Downloading...${RESET}"
curl -#L $URL -o $TEMP_FILE

echo -e "${BLUE}Extracting...${RESET}"
tar -xJ -C $PKGDIR -f $TEMP_FILE

# echo -e "${BLUE}Removing temporary file...${RESET}"
rm -rf $TEMP_FILE

echo -e "${MAGENTA}Package '$PKG' downloaded.${RESET}"
