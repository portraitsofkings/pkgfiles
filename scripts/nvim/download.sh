#!/usr/bin/env bash

# Exit immediately on uncaught errors
set -e

PKGFILES="$HOME/.pkgfiles"
source $PKGFILES/scripts/lib/shared.sh

PKG="nvim"
PKGDIR="$STOWDIR/$PKG"

VERSION="0.12.2"
ARCHITECTURE="x86_64"
FILE="nvim-linux-${ARCHITECTURE}.tar.gz"
URL="https://github.com/neovim/neovim/releases/download/v${VERSION}/$FILE"

if [ -d "$PKGDIR" ]; then
  echo -e "${BLUE}Removing old package files...${RESET}"
  rm -rf $PKGDIR
fi

echo -e "${BLUE}Creating package directory structure...${RESET}"
mkdir -p $PKGDIR

TEMP_FILE=$(mktemp)

echo -e "${BLUE}Downloading...${RESET}"
curl -#L $URL -o $TEMP_FILE

echo -e "${BLUE}Extracting...${RESET}"
tar --strip-components=1 -xf $TEMP_FILE -C $PKGDIR

rm -rf $TEMP_FILE

echo -e "${MAGENTA}Package '$PKG' downloaded.${RESET}"
