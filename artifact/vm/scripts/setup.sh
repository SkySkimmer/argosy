#!/bin/bash

set -e

## install dependencies
# artifact dependencies
sudo apt install -y opam cloc sqlite3
# conveniences for VM
sudo apt install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-utils vim firefox

# install stack
wget -qO- https://get.haskellstack.org/ | sh
stack setup --resolver=lts-13.8

# install Coq
opam init --auto-setup
eval $(opam config env)
opam repo add coq-released https://coq.inria.fr/opam/released/
opam install -j2 -y coq.8.9.0

## set up artifact
# we do a build first to set up the stack cache
cd /tmp
tar -xf /tmp/argosy-artifact.tar.gz
cd /tmp/argosy-artifact/argosy
make -j2
cd logging-client
stack test

cd ~/
tar -xf /tmp/argosy-artifact.tar.gz
