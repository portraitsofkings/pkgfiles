#!/usr/bin/env bash

# Exit immediately on uncaught errors
set -e

PKGFILES="$HOME/.pkgfiles"
STOWDIR="$PKGFILES/stow"
TARGETDIR="/usr/local"

RESET="\e[0m"
RED="\e[0;31m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
MAGENTA="\e[0;35m"

# Updates sudo cache
sudo_refresh() {
  sudo -v
}

stow_pkg() {
  local pkg=$1
  local pkgdir="$STOWDIR/$pkg"
  echo -e "${BLUE}Stowing package '$pkg'...${RESET}"

  if [ ! -d "$pkgdir" ]; then
    echo -e "${RED}Package '$pkg' doesn't exist.${RESET}"
    return 1
  fi

  sudo stow -v -d $STOWDIR -t $TARGETDIR $pkg
}

unstow_pkg() {
  local pkg=$1
  local pkgdir="$STOWDIR/$pkg"

  echo -e "${BLUE}Unstowing package '$pkg'...${RESET}"

  if [ ! -d "$pkgdir" ]; then
    echo -e "${RED}Package '$pkg' doesn't exist.${RESET}"
    return 1
  fi

  sudo stow -v -d $STOWDIR -t $TARGETDIR -D $pkg
}

download_pkg() {
  local pkg=$1
  local script=$PKGFILES/scripts/${pkg}/download.sh

  echo -e "${BLUE}Downloading package '$pkg'...${RESET}"

  if [ ! -f "$script" ]; then
    echo -e "${RED}Download script for '$pkg' doesn't exist.${RESET}"
    return 1
  fi

  bash "$script"
}

install_pkg() {
  local pkg=$1
  local pkgdir="$STOWDIR/$pkg"

  echo -e "${BLUE}Installing package '$pkg'...${RESET}"

  if [ ! -d "$pkgdir" ]; then
    download_pkg $pkg
  else
    echo -en "${YELLOW}Package '$PKG' already exists. Download again? [Y/n]${RESET} "

    local answer
    read -r answer

    case "$answer" in
      Y|y|"")
        download_pkg $pkg
        ;;
      *)
        echo -e "${YELLOW}Download skipped.${RESET}"
        ;;
    esac
  fi

  stow_pkg $PKG

  echo -e "${MAGENTA}Package '$PKG' installed.${RESET}"
}

uninstall_pkg() {
  local pkg=$1
  local pkgdir="$STOWDIR/$pkg"

  echo -e "${BLUE}Uninstalling package '$pkg'...${RESET}"

  if ! unstow_pkg $pkg; then
    return 1
  fi

  echo -e "${BLUE}Removing 'stow/$pkg'...${RESET}"
  rm -rf $pkgdir

  echo -e "${MAGENTA}Package '$PKG' uninstalled.${RESET}"
}
