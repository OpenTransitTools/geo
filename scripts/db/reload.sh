##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/../base.sh

cd ~/geo/geoserver
docker-compose down
wait 4

cd ~/geo/
$DIR/drop.sh
sleep 1
$DIR/create.sh
sleep 1
$DIR/load.sh
sleep 4

$DIR/file.sh gs_sql_view.txt

cd ~/geo/geoserver
nohup docker-compose up &
