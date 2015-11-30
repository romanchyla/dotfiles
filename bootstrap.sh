#!/bin/bash


git clone https://github.com/romanchyla/dotfiles.git .

CWD=`pwd`

mkdir -p gitencrypt

# curl https://raw.githubusercontent.com/romanchyla/dotfiles/master/gitencrypt/clean_filter_openssl > gitencrypt/clean_filter_openssl
# curl https://raw.githubusercontent.com/romanchyla/dotfiles/master/gitencrypt/diff_filter_openssl > gitencrypt/diff_filter_openssl
# curl https://raw.githubusercontent.com/romanchyla/dotfiles/master/gitencrypt/smudge_filter_openssl > gitencrypt/smudgei_filter_openssl
# 
# chmod 750 gitencrypt/*

git config --local filter.openssl.smudge "$CWD/gitencrypt/smudge_filter_openssl"
git config --local filter.openssl.clean "$CWD/gitencrypt/clean_filter_openssl"
git config --local diff.openssl.textconv "$CWD/gitencrypt/diff_filter_openssl"



