#!/bin/bash


sudo apt install libssl-dev
chw
git clone https://github.com/AGWA/git-crypt.git
cd git-crypt/
make
sudo make install
