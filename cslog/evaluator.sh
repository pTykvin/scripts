#!/bin/bash

source initializer.sh

function Evaluator() {
  printf "%$((-LINEWIDTH+4))s" $1 | tr " " "." | tr "_" " "
  eval $1
  case $? in
    0 )
      echo -e "..${GREEN}OK${CLEAR}"
      ;;
    1 )
      echo -e "${YELLOW}WARN${CLEAR}"
      ;;
    * )
      echo -e ".${ORANGE}ERR${CLEAR}"
      exit $?
      ;;
  esac
}

