#!/usr/bin/env bash

sudo pacman -Sy archlinux-keyring --noconfirm
sudo pacman -Su --noconfirm

OLD_VERSION=$(grep 'julia_version' Manifest.toml | cut -d '"' -f 2 | tr -d '.')
VERSION=$(julia --version)
NEW_VERSION=$(echo "$VERSION" | sed -n 's/.*julia version \([0-9.]*\).*/\1/p' | tr -d '.')

if [[ $NEW_VERSION -gt $OLD_VERSION ]]; then
  if [ -f Project.toml ]; then
    printf '%s\n' "Removing Lock file"
    rm -r *.toml
    julia -e 'using Pkg; Pkg.activate(""); Pkg.add("IJulia")'
  fi
fi
