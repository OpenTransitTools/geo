##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/../base.sh

data_dir="~/rtp/map_server/data_dir"
db_snaps="~/gtfs/cache/*.sql"

UPDATE=${1:-"GET_MACH"}

if [ $UPDATE == "GET_MACH" ]; then
  unset MACHINES
  . $DIR/get_machines.sh
fi

for m in $UPDATE
do
  # backup GTFS dir on machine
  cmd="ssh ${m} 'rm -rf ~/tmp/gtfs; cp -r ~/gtfs /tmp/; rm -rf ~/gtfs; mkdir ~/gtfs'"
  echo $cmd
  eval $cmd

  # TODO - stop geoserver

  # copy geoserver data_dir over 
  cmd="scp -r $data_dir ${m}:${PWD}/geoserver/"
  echo $cmd
  eval $cmd

  # copy snapshots over
  cmd="scp $db_snaps ${m}:~/gtfs/"
  echo $cmd
  eval $cmd

  # copy give script over
  cmd="scp $db_view ${m}:~/geo/"
  echo $cmd
  eval $cmd

  sleep 1
done


# TODO: reload & restart 
echo
for m in $UPDATE
do
  cmd="ssh $m"
  echo $cmd
  echo
done

