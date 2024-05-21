#!/bin/bash
set -eu

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT/docs"


DIST_DIR="dists/stable"
BIN_DIR="$DIST_DIR/main/binary-amd64"
dpkg-scanpackages pool/ > $BIN_DIR/Packages
cat $BIN_DIR/Packages | gzip -9 > $BIN_DIR/Packages.gz
apt-ftparchive release $BIN_DIR > $BIN_DIR/Release
gpg --default-key "support@insightreactions.com" -abs -o - $BIN_DIR/Release > $BIN_DIR/Release.gpg
gpg --default-key "support@insightreactions.com" --clearsign -o - $BIN_DIR/Release > $BIN_DIR/InRelease

apt-ftparchive release $DIST_DIR > $DIST_DIR/Release
gpg --default-key "support@insightreactions.com" -abs -o - $DIST_DIR/Release > $DIST_DIR/Release.gpg
gpg --default-key "support@insightreactions.com" --clearsign -o - $DIST_DIR/Release > $DIST_DIR/InRelease
