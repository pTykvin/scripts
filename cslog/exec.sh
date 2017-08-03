#!/bin/bash
src="`pwd`/$1"
cd `dirname $(realpath $0)`

source initializer.sh
source unpacker.sh
source evaluator.sh
source printer.sh
source analizer.sh
source worker.sh

function _() {

  InitFile $src
  Evaluator Unpack
  Analize
  PrintCommonsInfo
  Work
  Unset

}

_
