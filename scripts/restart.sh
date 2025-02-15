#
# restart geoserver and postgis
#
REDIR=`dirname $0`
. $REDIR/base.sh

DO_GEO=${1:-"TRUE"}
DO_DB=${2:-"TRUE"}

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
  docker system prune -a -f; sleep 2
  rm -f $GS_LOG
  tmux new-session -d -s postgres_ses "docker-compose up > $GS_LOG 2>&1"
  sleep 2
  cd -
fi

# startup geoserver
if [ $DO_GEO == "TRUE" ]; then
  cd $GS_DIR
  echo $PWD
  tmux new-session -d -s geoserver_ses "docker-compose up > $GS_LOG 2>&1"
  sleep 2
  cd -
fi
