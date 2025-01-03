##
## load gtfsdb spatial db for OTT
## *note*: requires the ott db to exist 
##
LDDIR=`dirname $0`
. $LDDIR/../base.sh
. $LDDIR/shapes.sh
. $LDDIR/schemas.sh

# put loader project's bin dir here for gtfsdb creation from *gtfs.zip
ln -s ~/rtp/loader/bin . > /dev/null 2>&1

chk=${GTFS_DIR}/TRIMET.gtfs.zip
if [ -f $chk ]; then
  # remove old .sql files from gtfs dir
  rm -f ${GTFS_DIR}/*.sql ${GTFS_DIR}/*schema

  # create "current" schema (in addition to gtfs agency schemas)
  make_schema "current"
  load_schemas

  # grab and load the shape .sql files
  get_shps
  load_shps

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

  # load any (materialized) views  
  for v in ${GTFS_DIR}/*.views
  do
    echo "load view: $v"
    r="$LDDIR/file.sh $v"
    echo $r
    eval $r
    echo
  done
  echo;  echo;
else
  echo file $chk does not exist.
fi
