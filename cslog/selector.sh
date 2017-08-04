#!/bin/bash
source initializer.sh

function Select() {

  PrintItems "$@"
  WhaitSelection "$@"
  return $?
}

function PrintItems() {
  echo -e "\n${YELLOW}Available actions:\n${CLEAR}"
  for i in `seq 1 $#`; do
    echo -e "${YELLOW}$i${CLEAR}: "${!i}""
  done
  echo -e "\n${YELLOW}0${CLEAR}: Exit"

}

function WhaitSelection() {
  echo -en "\n${YELLOW}What do you want?: ${CLEAR}"
  read -n 1 result
  echo
  re="^[0-$#]+$"
  if ! [[ $result =~ $re ]] ; then
    WhaitSelection
  elif [[ $result == 0 ]]; then
    echo "Good bye"
    exit 0
  else
    echo -en "\n${YELLOW}\"${!result}\"${CLEAR} was selected\n\n"
    return $result
  fi
}