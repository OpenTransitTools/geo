##
## load gtfsdb spatial db for OTT
## *note*: requires the ott db to exist 
##
LDDIR=`dirname $0`
. $LDDIR/../base.sh

# put loader project's bin dir here for gtfsdb creation from *gtfs.zip
ln -s ~/rtp/loader/bin . > /dev/null 2>&1

if [ -f ${GTFS_DIR}/TRIMET.gtfs.zip ]; then
  # remove old .sql files from gtfs dir
  rm -f ${GTFS_DIR}/*.sql

  # grab any new .sql files that will get loaded
  $GDIR/scripts/data/shapes.sh

  # create current schema
  $GDIR/scripts/db/psql.sh "create schema current"

  # load any new .sql files
  for x in ${GTFS_DIR}/*.sql
  do
    cmd="$GDIR/scripts/db/file.sh $x"
    echo $cmd
    eval $cmd
  done

  # load gtfs feeds into gtfsdb
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
