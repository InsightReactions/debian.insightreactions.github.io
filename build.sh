#!/bin/bash
set -eu

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT/docs"

generate_release() {
    local dist_dir=$1
    local bin_dir=$2
    dpkg-scanpackages pool/ > $bin_dir/Packages
    cat $bin_dir/Packages | gzip -9 > $bin_dir/Packages.gz
    apt-ftparchive release $bin_dir > $bin_dir/Release
    gpg --default-key "support@insightreactions.com" -abs -o - $bin_dir/Release > $bin_dir/Release.gpg
    gpg --default-key "support@insightreactions.com" --clearsign -o - $bin_dir/Release > $bin_dir/InRelease

    apt-ftparchive release $dist_dir > $dist_dir/Release
    gpg --default-key "support@insightreactions.com" -abs -o - $dist_dir/Release > $dist_dir/Release.gpg
    gpg --default-key "support@insightreactions.com" --clearsign -o - $dist_dir/Release > $dist_dir/InRelease
}

# Call the function with the required parameters
generate_release "dists/stable" "dists/stable/main/binary-amd64"
generate_release "dists/testing" "dists/testing/main/binary-amd64"
