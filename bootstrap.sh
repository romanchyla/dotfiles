#!/bin/bash

CWD=`pwd`

git config --local filter.openssl.smudge "$CWD/gitencrypt/smudge_filter_openssl"
git config --local filter.openssl.clean "$CWD/gitencrypt/clean_filter_openssl"
git config --local diff.openssl.textconv "$CWD/gitencrypt/diff_filter_openssl"
git config --local merge.renormalize true


