#
# restart geoserver and postgis
#
REDIR=`dirname $0`
. $REDIR/base.sh

DO_GEO=${1:-"TRUE"}
DO_DB=${2:-"TRUE"}
DOC_PRUNE=${3:-"FALSE"}

date

# shutdown geoserver
if [ $DO_GEO == "TRUE" ]; then
  cd $GS_DIR
  echo $PWD
  docker-compose down -v; sleep 2
  cd -
fi

# re-start postgis
if [ $DO_DB == "TRUE" ]; then
  cd $PG_DIR
  echo $PWD
  docker-compose down; sleep 5

  if [ $DOC_PRUNE == "TRUE" ]; then
    docker system prune -a -f; sleep 2
  fi

  rm -f $GS_LOG
  docker-compose up -d > $GS_LOG 2>&1
  sleep 2
  cd -
fi

# startup geoserver
if [ $DO_GEO == "TRUE" ]; then
  cd $GS_DIR
  echo $PWD
  docker-compose up -d > $GS_LOG 2>&1
  sleep 2
  cd -
fi
