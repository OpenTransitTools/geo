##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`


unset MACHINES
. $DIR/get_machines.sh

data_dir="~/rtp/map_server/data_dir"
db_snaps="~/gtfs/cache/*.sql"

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

  sleep 1
done
