#!/bin/bash

source initializer.sh
source postgres.sh
source selector.sh

function AfterAnalize() {

  Select \
    "Restore cash database" \
    "Analize logs with ELK" \
    "I want everything"
  DoAfterAnalize $?

}

function AfterPostgres() {
  Select "Connect with psql"
  DoAfterPostgres $?

}

function DoAfterPostgres() {

  case $1 in
    1 )
      Connect
      ;;
  esac

}

function DoAfterAnalize() {
  case $1 in
    1 )
      Pg
      [ $? == $OK ] && AfterPostgres || AfterAnalize
      ;;
    2 )
      ;;
    3 )
      ;;
  esac
}
