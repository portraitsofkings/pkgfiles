#!/usr/bin/env bash

PKGFILES="$HOME/.pkgfiles"
source $PKGFILES/scripts/lib/shared.sh

# Exit immediately on uncaught errors
set -e

# Update sudo cache
sudo -v

PKG="kitty"
PKGDIR="$STOWDIR/$PKG"

uninstall_pkg $PKG
