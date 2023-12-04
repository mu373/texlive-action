#!/usr/bin/env bash

set -e

# Install fonts
apt-get update -y
apt-get install -y wget 
wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.8.1_all.deb
apt install -y ./ttf-mscorefonts-installer_3.8.1_all.deb
# Reset font cache
fc-cache -f -v

tex_files="${1}"
compiler="${2}"
options="${3}"

if [[ -z "$tex_files" ]]; then
  echo "Input 'tex_files' is missing."
fi

if [[ -z "$compiler" && -z "$options" ]]; then
  echo "Input 'compiler' and 'options' are both empty. Reset them to default values."
  compiler="latexmk"
  options="-pdf -quiet -cd"
fi

while IFS= read -r f; do
  if [[ -z "$f" ]]; then
    continue
  fi

  echo "::group::Compiling $f..."

  if [[ ! -f "$f" ]]; then
    echo "File '$f' cannot be found."
  fi

  ${compiler} ${options} $f
  
  echo "::endgroup::"
  
done <<< "$tex_files"
