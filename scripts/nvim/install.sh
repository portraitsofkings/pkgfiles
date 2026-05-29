#!/usr/bin/env bash

# Exit immediately on uncaught errors
set -e

PKGFILES="$HOME/.pkgfiles"
source $PKGFILES/scripts/lib/shared.sh

sudo_refresh

PKG="nvim"
PKGDIR="$STOWDIR/$PKG"

install_pkg $PKG
