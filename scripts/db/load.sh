##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/../base.sh

# put loader's bin dir here
ln -s ~/rtp/loader/bin . > /dev/null 2>&1

if [ -f ${GTFS_DIR}/TRIMET.gtfs.zip ]; then
  for f in ${GTFS_DIR}/*gtfs.zip
  do
    name=$(feed_name_from_zip $f)  

    cmd="bin/gtfsdb-load -c -ct -g -d $otp_url -s ${name} ${f}"
    echo $cmd
    eval $cmd
    sleep 1

    dump="$pg_dump $db -n ${name} > ${GTFS_DIR}/${name}.sql"
    echo $dump
    eval $dump

    echo;
  done
  echo;  echo;
fi
