#!/bin/bash
source initializer.sh

function mime() {

  echo `file $SOURCE --mime-type | sed 's/.* //'`

}


function Unpack() {

  local tmp=`mktemp -d --suffix=$SUFFIX`
  local mime=`mime`
  local cmd
  case $mime in
    application/gzip ) # Extract .cslog
      tar -xf $SOURCE -C $tmp
      export WORKDIR=$tmp
    ;;
    application/zip ) # Extract zip
      unzip -q $SOURCE -d $tmp
      if [[ -d $tmp/crystal-cash ]]; then
        export WORKDIR=$tmp/crystal-cash
      else
        echo "Unknown file structure. Extracted to $tmp"
        echo $tmp | xclip
        return $ERR
      fi
    ;;
    * )
      echo "Unsupported file type $mime"
      return $ERR
    ;;
  esac
  return $OK

}

