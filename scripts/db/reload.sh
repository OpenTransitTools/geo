##
## reload OTT spatial db and enable new geoserver data_dir
##
DIR=`dirname $0`
. $DIR/../base.sh

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
if [ -f $GTFS_DIR/trimet.sql ]; then
  $DIR/drop.sh
  sleep 1
  $DIR/create.sh
  sleep 1
  $DIR/restore.sh
  sleep 2
fi

# bring geoserver back up
cd $GEO_DIR
rm -f $GEO_LOG
tmux new-session -d -s geoserver_ses "docker-compose up > $GEO_LOG 2>&1"
cd -
