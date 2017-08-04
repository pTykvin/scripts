#!/bin/bash

source initializer.sh
source postgres.sh
source selector.sh

function AfterAnalize() {

  Select "Restore cash database" "Analize logs with ELK" "I want everything"
  DoAfterAnalize $?

}

function AfterPostgres() {
  Select "Connect with psql"
  DoAfterPostgres $?

}

function DoAfterPostgres() {

  case $1 in
    1 )
      psql -U postgres -p $PGPORT -h localhost
      ;;
  esac

}

function DoAfterAnalize() {
  case $1 in
    1 )
      Pg
      AfterPostgres
      ;;
    2 )
      ;;
    3 )
      ;;
  esac
}