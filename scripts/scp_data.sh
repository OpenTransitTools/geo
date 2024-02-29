##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`

data_dir="~/rtp/map_server/data_dir"
machines="rj-st-mapapp01 cs-st-mapapp01"
for m in $machines
do
  cmd="scp -r $data_dir $m:$PWD/geoserver/"
  echo $cmd
  eval $cmd
done
