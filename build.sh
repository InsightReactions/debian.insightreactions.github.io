#!/bin/bash
set -eu

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT/docs"

generate_release() {
    local pool=$1
    local dist_dir="dists/${pool}"
    local bin_dir="${dist_dir}/main/binary-amd64"
    dpkg-scanpackages "pool/${pool}" > $bin_dir/Packages
    cat $bin_dir/Packages | gzip -9 > $bin_dir/Packages.gz
    apt-ftparchive release $bin_dir > $bin_dir/Release
    gpg --default-key "support@insightreactions.com" -abs -o - $bin_dir/Release > $bin_dir/Release.gpg
    gpg --default-key "support@insightreactions.com" --clearsign -o - $bin_dir/Release > $bin_dir/InRelease

    apt-ftparchive release $dist_dir > $dist_dir/Release
    gpg --default-key "support@insightreactions.com" -abs -o - $dist_dir/Release > $dist_dir/Release.gpg
    gpg --default-key "support@insightreactions.com" --clearsign -o - $dist_dir/Release > $dist_dir/InRelease
}

# Call the function with the required parameters
generate_release "stable"
generate_release "testing"

