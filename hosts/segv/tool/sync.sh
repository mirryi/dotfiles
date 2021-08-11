#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
HERE="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
DEST=$(realpath "$HERE/..")

reset() {
  local rel="$1"
  local dest="$DEST/$rel"

  if [[ ! -d "$dest" ]]; then
    mkdir -p "$dest"
  else
    rm -r "$dest/"*
  fi
}

reset etc/portage
cp -r /etc/portage/{package.*,profile,repos.conf,make.conf,smart-live-rebuild.conf} "$DEST/etc/portage/"

reset etc/modules-load.d
cp -r /etc/modules-load.d/* "$DEST/etc/modules-load.d/"
