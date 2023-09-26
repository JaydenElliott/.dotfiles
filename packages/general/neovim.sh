#!/bin/bash
cargo install --git https://github.com/MordechaiHadad/bob.git
bob use stable

cargo install --locked --all-features \
  --git https://github.com/ms-jpq/sad --branch senpai
