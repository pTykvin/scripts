#!/bin/bash

source unset.sh

function InitFile() {
  local pwd=`pwd`
  cd $2
  if [ -f $1 ]; then
    sudo echo

    Unset

    ## Consts

    SUFFIX=cslog
    SCRIPTDIR=$pwd
    CLEAR="\e[0m"
    GREEN="\e[32m"
    YELLOW="\e[1;33m"
    ORANGE="\e[0;31m"
    LINEWIDTH=80

    ## Vars

    WORKDIR=
    VERSION=
    UUID=
    MODEL=
    DB=
    PG_PORT=

    ##

    rm -rf /tmp/tmp.*$SUFFIX}
    export SOURCE=$2/$1
  else
    echo "Wrong file: $1"
    exit 1
  fi
  cd $pwd
}
