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
  if [[ -z $version ]]; then
    return 100
  fi
}

function Extract_UUID() {
  if [[ -f $WORKDIR/licenses/license.properties ]]; then
    uuid=`cat $WORKDIR/licenses/license.properties | grep uuid | sed 's/uuid = //'`
    return 0
  fi
  return 100
}

function Extract_Model() {
  local modelfile=$WORKDIR/device_info.properties
  if [ -f $modelfile ]; then
    model=`cat $WORKDIR/device_info.properties | grep model | sed 's/model=//'`
    return 0
  else
    model='UNKNOWN'
    return 100
  fi
}