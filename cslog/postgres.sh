#!/bin/bash

source evaluator.sh
source printer.sh

function Pg() {

  Evaluator Search_Dumps

  if [[ ! -z $DB ]]; then

    Evaluator Start_Postgres
    Evaluator Extract_Postgres_Port
    Evaluator Create_Databases
    Evaluator Restore_Data
    PrintPostgresInfo
    return $?

  else

    echo "Can't find database dumps"
    return 1

  fi


}

function Search_Dumps() {
  local dumps
  for dump in `ls -1 $WORKDIR/db/`; do
    if [[ -s $WORKDIR/db/$dump ]]; then
      db=`echo $dump | tr "." " " | awk '{ print $1 }'`
      size=`du -h $WORKDIR/db/$dump | awk '{ print $1 }'`
      dumps[${#dumps[@]}]="${db}:${dump}:${size}"
    fi
  done
  export DB=${dumps[@]}
}

function Start_Postgres() {

  cd $SCRIPTDIR
  sudo docker-compose -f $SCRIPTDIR/docker-compose.yml -p $SUFFIX up -d --force-recreate --remove-orphans >/dev/null 2>&1
  return $?

}

function Extract_Postgres_Port() {

  export PGPORT=`sudo docker-compose -f $SCRIPTDIR/docker-compose.yml -p $SUFFIX ps | grep cslog_postgres_1 | sed -n 's/.*:\([0-9]*\).*/\1/p'`
  return $?

}

function Create_Databases() {
  for db in $DB ; do
    db=`echo $db | awk -F: '{ print $1 }'`
    psql -U postgres -h localhost -p $PGPORT -c "DROP DATABASE IF EXISTS \"$db\";" >/dev/null 2>&1
    psql -U postgres -h localhost -p $PGPORT -c "CREATE DATABASE \"$db\";" >/dev/null 2>&1
  done
}

function Restore_Data() {
  for db in $DB ; do
    dump=`echo $db | awk -F: '{ print $2 }'`
    db=`echo $db | awk -F: '{ print $1 }'`
    pg_restore -h localhost -p $PGPORT -U postgres -C -d $db $WORKDIR/db/$dump >/dev/null 2>&1
  done
  return 0
}

function Connect() {

  echo -en "\n${YELLOW}Connect to db? [y/n]: ${CLEAR}"
  read -n 1 result
  case $result in
    y )
      i=0
      for db in `ls -1 $WORKDIR/db/ | tr "." " " | awk '{ print $1 }'`; do
        $((i++))
        echo "$i: $db"
        dbs[$i]=$db
      done
      echo -en "\n${YELLOW}Select database: ${CLEAR}"
      read -n 1 result
      psql -U postgres -d
      ;;
    n )
      Pg
      ;;
    * )
      Connect
      ;;
  esac

}
