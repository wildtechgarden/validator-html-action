#!/bin/bash
# cspell:ignore validatehtml

set -e
set -o pipefail

rm -rf public

export BASEURL="https://www.validator-html-action.wtg-demos.ca/"
export HUGO_RESOURCEDIR="$(pwd)"/resources
export SITECONFIG="$(pwd)"/tests/config/hugo.toml
export TARGET="$(pwd)"/public
export CURDIR="$(pwd)"

cd tests/config && hugo --gc --minify -b $BASEURL --source "$(pwd)" --destination "${TARGET}" --config "${SITECONFIG}"
cd "${CURDIR}"
rclone sync --progress --checksum public/ wtg-validatehtml:./
