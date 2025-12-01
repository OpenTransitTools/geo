##
## reload OTT spatial db and enable new geoserver data_dir
##
RLDIR=`dirname $0`
. $RLDIR/../base.sh

load_script=${1:-"$RLDIR/restore.sh"}
load_test=${2:-"$GTFS_DIR/trimet.sql"}

if [ -f $load_test ]; then
  # take geoserver down
  cd $GS_DIR
  docker compose down
  sleep 2
  cd -

  # move clean data_dir into geoserver/ instance
  if [ -d $GTFS_DIR/data_dir ]; then
    rm -rf $GS_DIR/data_dir
    cp -r $GTFS_DIR/data_dir $GS_DIR/
  fi

  # restart db
  $RLDIR/../restart.sh FALSE TRUE
  echo waiting till pg comes back up
  $RLDIR/wait.sh

  # load the db with new shp data
  $RLDIR/drop.sh
  sleep 1
  $RLDIR/create.sh
  sleep 1
  $load_script
  sleep 2

  # bring geoserver back up
  cd $GS_DIR
  rm -f $GS_LOG
  docker compose up -d > $GS_LOG 2>&1
  cd -
else
  echo "required file \"$load_test\" doen't exist, so won't try reloading the db"
fi
