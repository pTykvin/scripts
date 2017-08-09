#!/bin/bash

source evaluator.sh
source printer.sh
source selector.sh

function Pg() {

  Evaluator Search_Dumps

  if [ $? == $OK ]; then

    Evaluator Start_Postgres
    Evaluator Extract_Postgres_Port
    Evaluator Create_Databases
    Evaluator Restore_Data
    PrintPostgresInfo
    return $?

  else

    echo "Database dumps not found"
    return $WARN

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
  [ ! -z $DB ] && return $OK || return $WARN
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
    psql -U postgres -h localhost -p $PGPORT -c "DROP DATABASE IF EXISTS \"`GetDb $db`\";" >/dev/null 2>&1
    psql -U postgres -h localhost -p $PGPORT -c "CREATE DATABASE \"`GetDb $db`\";" >/dev/null 2>&1
  done
}

function Restore_Data() {
  for db in $DB ; do
    pg_restore -h localhost -p $PGPORT -U postgres -C -d `GetDb $db` $WORKDIR/db/`GetDump $db` >/dev/null 2>&1
  done
  return $OK
}

function Connect() {
  local db
  local dbs
  for d in $DB; do
    dbs[${#dbs[@]}]=`GetDb $d`
  done
  if [[ ${#dbs[@]} == 1 ]]; then
    db=dbs[0]
  else
    Select ${dbs[@]}
    s=$?
    db=${dbs[$((s-1))]}
  fi
  psql -U postgres -p $PGPORT -h localhost -d $db
}

function GetDb() {
  echo $1 | awk -F: '{ print $1 }'
}

function GetDump() {
  echo $1 | awk -F: '{ print $2 }'
}

function GetSize() {
  echo $1 | awk -F: '{ print $2 }'
}
