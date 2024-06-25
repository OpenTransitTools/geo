##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/../base.sh

FEEDS_DIR="$HOME/gtfs/cache"
for f in ${FEEDS_DIR}/*gtfs.zip
do
  name=$(feed_name_from_zip $f)
  dump="$pg_dump $db -n ${name} > ${FEEDS_DIR}/${name}.sql"
  echo $dump
  eval $dump
  tail ${FEEDS_DIR}/${name}.sql
  sleep 2
done
