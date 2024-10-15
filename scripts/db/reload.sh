##
## reload OTT spatial db and enable new geoserver data_dir
##
DIR=`dirname $0`
. $DIR/../base.sh

load_script=${1:-"$DIR/restore.sh"}
load_test=${2:-"$GTFS_DIR/trimet.sql"}

if [ -f $load_test ]; then
  # take geoserver down
  cd $GEO_DIR
  docker-compose down
  sleep 1
  pkill -9 tmux
  sleep 2
  cd -

  # move clean data_dir into place
  if [ -d $GTFS_DIR/data_dir ]; then
    rm -rf $GEO_DIR/data_dir
    mv $GTFS_DIR/data_dir $GEO_DIR/
  fi

  # load the db with new shp data
  $DIR/drop.sh
  sleep 1
  $DIR/create.sh
  sleep 1
  $load_script
  sleep 2


  # bring geoserver back up
  cd $GEO_DIR
  rm -f $GEO_LOG
  tmux new-session -d -s geoserver_ses "docker-compose up > $GEO_LOG 2>&1"
  cd -
else
  echo "$GTFS_DIR/trimet.sql doen't exist ... won't reload db"
fi
