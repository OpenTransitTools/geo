##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`


unset MACHINES
. $DIR/get_machines.sh

data_dir="~/rtp/map_server/data_dir"
db_snaps="~/gtfs/cache/*.sql"
db_view="~/geo/gs_sql_view.txt"

for m in $UPDATE
do
  cmd="ssh ${m} 'rm -rf ~/tmp/gtfs; cp -r ~/gtfs /tmp/; rm -rf ~/gtfs; mkdir ~/gtfs'"
  echo $cmd
  eval $cmd

  cmd="scp -r $data_dir ${m}:${PWD}/geoserver/"
  echo $cmd
  eval $cmd

  cmd="scp $db_snaps ${m}:~/gtfs/"
  echo $cmd
  eval $cmd

  cmd="scp $db_view ${m}:~/geo/"
  echo $cmd
  eval $cmd

  sleep 1
done
