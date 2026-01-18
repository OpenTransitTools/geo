#
# restart geoserver
#
REDIR=`dirname $0`
. $REDIR/base.sh

DOC_PRUNE=${1:-"TRUE"}
date

# shutdown geoserver
cd $REDIR/../
echo $PWD
docker compose down -v
sleep 2

if [ $DOC_PRUNE == "TRUE" ]; then
  cmd="docker system prune -a -f"
  echo $cmd
  eval $cmd
  sleep 2
fi

# startup geoserver
docker compose up -d > $GS_LOG 2>&1
cd -
