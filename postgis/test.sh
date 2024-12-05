C=${1:-"N"}
S=5
if [[ $C == STK* ]]; then
  ~/server-config/docker/nuke.sh ALL
  S=300
fi
if [[ $C == ST* ]]; then
  echo start postgis
  docker compose down
  sleep 2
  nohup docker compose up &
  sleep $S
fi
if [[ $C == S* ]]; then
  echo start geoserver
  cd ~/geo/geoserver
  docker compose down
  sleep 2
  nohup docker compose up &
  sleep $S
  cd -
fi
if [[ $C == STKZ* ]]; then
  ~/server-config/servers/update/geoserver/build.sh
else
  ~/geo/scripts/db/create.sh
  ~/geo/scripts/data/rename.sh
  ~/geo/scripts/db/restore.sh
fi

docker ps
