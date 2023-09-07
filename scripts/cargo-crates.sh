#!/bin/bash

cargo install cargo-udeps
cargo install cargo-info
cargo install simple-http-server

# neovim
cargo install --git https://github.com/MordechaiHadad/bob.git
bob use stable

cargo install --locked --all-features \
  --git https://github.com/ms-jpq/sad --branch senpai

# tldr
cargo install tealdeer
tldr --seed-config


