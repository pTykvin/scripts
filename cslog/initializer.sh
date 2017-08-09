#!/bin/bash

source unset.sh

function InitFile() {
  if [ -f $1 ]; then
    sudo echo

    Unset

    ## Consts

    SUFFIX=cslog
    SCRIPTDIR=`dirname $(realpath $0)`
    CLEAR="\e[0m"
    GREEN="\e[32m"
    YELLOW="\e[1;33m"
    ORANGE="\e[0;31m"
    LINEWIDTH=80
    OK=0
    WARN=100
    ERR=200
    
    ## Vars

    WORKDIR=
    VERSION=
    UUID=
    MODEL=
    DB=
    PGPORT=

    ##

    rm -rf /tmp/tmp.*$SUFFIX
    export SOURCE=$1
  else
    echo "Wrong file: $1"
    exit 1
  fi
}

function Exit() {
  echo "Good bye"
  exit 0
}
