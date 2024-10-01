##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/../base.sh

for f in ${GTFS_DIR}/*gtfs.zip
do
  name=$(feed_name_from_zip $f)
  dump="$pg_dump $db -n ${name} > ${GTFS_DIR}/${name}.sql"
  echo $dump
  eval $dump
  tail ${GTFS_DIR}/${name}.sql
  sleep 2
done
