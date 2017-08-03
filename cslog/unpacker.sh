#!/bin/bash
source initializer.sh

function mime() {

  echo `file $SOURCE -z --mime-type | sed 's/.* //'`

}


function Unpack() {

  local tmp=`mktemp -d --suffix=$SUFFIX`
  local mime=`mime`
  local cmd
  case $mime in
    application/x-tar ) # Extract .cslog
      tar -xf $SOURCE -C $tmp
      export WORKDIR=$tmp
    ;;
    * )
      echo "Unsupported file type $mime"
      return 1
    ;;
  esac
  return 0

}

