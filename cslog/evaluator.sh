#!/bin/bash

source initializer.sh

function Evaluator() {
  printf "%$((-LINEWIDTH+4))s" $1 | tr " " "." | tr "_" " "
  eval $1
  result=$?
  case $result in
    $OK )
      echo -e "..${GREEN}OK${CLEAR}"
      ;;
    $WARN )
      echo -e "${YELLOW}WARN${CLEAR}"
      ;;
    * )
      echo -e ".${ORANGE}ERR${CLEAR}"
      exit $result
      ;;
  esac
  return $result
}

