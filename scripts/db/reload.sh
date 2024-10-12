##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/../base.sh

# take geoserver down
cd ~/geo/geoserver
docker-compose down
sleep 1
pkill -9 tmux
sleep 2
cd -

# move clean data_dir into place
if [ -d ~/gtfs/data_dir ]; then
  rm -rf ~/geo/geoserver/data_dir
  mv ~/gtfs/data_dir ~/geo/geoserver/
fi

# load the db with new shp data
if [ -f ~/gtfs/trimet.sql ]; then
  cd ~/geo/
  $DIR/drop.sh
  sleep 1
  $DIR/create.sh
  sleep 1
  $DIR/load.sh
  sleep 4
  $DIR/file.sh gs_sql_view.txt
  cd -
fi

# bring geoserver back up
cd ~/geo/geoserver
GSLOG=gs.log
rm -f $GSLOG
tmux new-session -d -s geoserver_ses "docker-compose up > $GSLOG 2>&1"
cd -
