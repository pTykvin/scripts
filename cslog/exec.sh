#!/bin/bash
pwd=`pwd`
cd `dirname $(realpath $0)`

source initializer.sh
source unpacker.sh
source evaluator.sh
source printer.sh
source analizer.sh
source worker.sh

cd $pwd

function _() {

  InitFile $1
  Evaluator Unpack
  Analize
  PrintCommonsInfo
  Work
  Unset

}

_ $1
