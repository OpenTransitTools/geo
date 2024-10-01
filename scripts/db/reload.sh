##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/../base.sh

# take geoserver down
cd ~/geo/geoserver
docker-compose down
sleep 5
cd -

# move clean data_dir into place
if [ -d ~/gtfs/data_dir ]; then
  rm -rf ~/geo/geoserver/data_dir
  mv ~/gtfs/data_dir ~/geo/geoserver/
fi

# load the db with new shp data
cd ~/geo/
$DIR/drop.sh
sleep 1
$DIR/create.sh
sleep 1
$DIR/load.sh
sleep 4
$DIR/file.sh gs_sql_view.txt
cd -

# bring geoserver back up
cd ~/geo/geoserver
nohup docker-compose up &
cd -
