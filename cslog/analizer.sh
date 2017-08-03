#!/bin/bash

source initializer.sh
source evaluator.sh

version=
uuid=
model=

function Analize() {
  Evaluator Extract_Version
  Evaluator Extract_UUID
  Evaluator Extract_Model
  export VERSION=$version
  export UUID=$uuid
  export MODEL=$model
}

function Extract_Version() {

  if [[ -f $WORKDIR/version ]]; then
    version=`cat $WORKDIR/version`
  else
    version=`cat $WORKDIR/config/register-modules.xml | grep productVersion | sed -n 's/.*productVersion="\([^"]*\).*/\1/p'`
  fi

}

function Extract_UUID() {

  uuid=`cat $WORKDIR/licenses/license.properties | grep uuid | sed 's/uuid = //'`
  return 0
}

function Extract_Model() {
  local modelfile=$WORKDIR/device_info.properties
  if [ -f $modelfile ]; then
    model=`cat $WORKDIR/device_info.properties | grep model | sed 's/model=//'`
    return 0
  else
    model='UNKNOWN'
    return 1
  fi
}