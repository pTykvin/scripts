#!/bin/bash

source initializer.sh

function PrintCommonsInfo() {

  rm -rf $WORKDIR/info
  printf "\n%80s\n" | tr " " "="
  PrintLine Home "$WORKDIR"
  PrintLine Version "$VERSION"
  PrintLine UUID "$UUID"
  PrintLine Model "$MODEL"
  printf "%80s\n\n" | tr " " "="

  echo -n $WORKDIR | xclip 2>/dev/null

}

function PrintPostgresInfo() {

  echo -ne "${YELLOW}Postgres is available on port $ORANGE$PG_PORT\n${YELLOW}Restored databases: $CLEAR\n"

  printf "\n%80s\n" | tr " " "="
  for db in $DB ; do
    dump=`echo $db | awk -F: '{ print $2 }'`
    size=`echo $db | awk -F: '{ print $3 }'`
    db=`echo $db | awk -F: '{ print $1 }'`
    PrintLine $db "${dump} (${size})"
  done
  printf "%80s\n" | tr " " "="

}

function PrintLine() {
  if [[ ! -z `echo $1 | tr -d [:space:]` ]]; then
    local key=$1
    local value=`echo -e $2 | tr -d [:space:]`
    printf "| %-24s|%51s |\n"  "$key" "$value"
  fi
}