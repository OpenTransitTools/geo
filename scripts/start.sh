#
# restart geoserver
#
REDIR=`dirname $0`
. $REDIR/base.sh

DO_PRUNE=${1:-"FALSE"}
date

# shutdown geoserver
cd $REDIR/../
echo $PWD
docker compose down -v
sleep 2

if [ $DO_PRUNE == "TRUE" ]; then
  docker system prune -a -f
fi

# startup geoserver
docker compose up -d > $GS_LOG 2>&1
cd -
