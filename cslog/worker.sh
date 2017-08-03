#!/bin/bash

source initializer.sh
source postgres.sh

function Work() {
  Selection
  Do
}

function Do() {
  echo -en "\n${YELLOW}What do you want?: ${CLEAR}"
  read -n 1 result
  echo
  case $result in
    0 )
      echo "Good bye"
      exit 0
      ;;
    1 )
      Pg
      ;;
    2 )
      ;;
    3 )
      ;;
    * )
      Do
      ;;
  esac
}

function Selection() {

  echo -e "${YELLOW}1${CLEAR}: Restore cash database"
  echo -e "${YELLOW}2${CLEAR}: Analize logs with ELK"
  echo -e "${YELLOW}3${CLEAR}: I want everything"
  echo -e "\n${YELLOW}0${CLEAR}: Exit"


}