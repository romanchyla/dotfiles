# Roman's Dot Files


## Installation
    git clone git@github.com:romanchyla/dotfiles.git /tmp/dotf
    cp -fr /tmp/dotf ~
    cd ~
    ./provision/install-gitcrypt.sh
    git-crypt unlock ~/.ssh/dotfiles.key
    cd ~
    rm -fr /tmp/dotf
