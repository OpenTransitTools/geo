##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`


unset MACHINES
. $DIR/get_machines.sh

data_dir="~/rtp/map_server/data_dir"
db_snaps=`ls ~/gtfs/cache/*ar`


for m in $MACHINES
do
  cmd="scp -r $data_dir $m:$PWD/geoserver/"
  echo $cmd
  #eval $cmd

  for d in $db_snaps
  do
    cmd="scp -r $d $m:$/gtfs/"
    echo $cmd
  done
done
