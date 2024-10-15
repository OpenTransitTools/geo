##
## restart geoserver and postgis
##
DIR=`dirname $0`
. $DIR/base.sh

DO_GEO=${1:-"TRUE"}
DO_DB=${2:-"TRUE"}

date

# shutdown geoserver
if [ $DO_GEO == "TRUE" ]; then
  cd $GEO_DIR
  docker-compose down -v; sleep 2
  cd -
fi

# re-start postgis
if [ $DO_DB == "TRUE" ]; then
  cd $PG_DIR
  docker-compose down -v; sleep 5
  docker network prune -f; sleep 2
  rm -f $GEO_LOG
  tmux new-session -d -s postgres_ses "docker-compose up > $GEO_LOG 2>&1"
  sleep 2
  cd -
fi

# startup geoserver
if [ $DO_GEO == "TRUE" ]; then
  cd $GEO_DIR
  tmux new-session -d -s geoserver_ses "docker-compose up > $GEO_LOG 2>&1"
  sleep 2
  cd -
fi
