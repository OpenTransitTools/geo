##
## load gtfsdb spatial db for OTT
## *note*: requires the ott db to exist 
##
LDDIR=`dirname $0`
. $LDDIR/../base.sh
. $LDDIR/shapes.sh
. $LDDIR/schemas.sh

required_feed=${1:-TRIMET}

chk=${GTFS_DIR}/${required_feed}.gtfs.zip
if [ -f $chk ]; then
  echo "INFO: starting the load as file $chk *does* exist."

  # remove old .sql files from gtfs dir
  rm -f ${GTFS_DIR}/*.sql ${GTFS_DIR}/*schema

  # create "current" schema (in addition to gtfs agency schemas)
  make_schema "current"
  load_schemas

  # grab and load the shape .sql files
  get_shps
  load_shps

  cd ~/gtfsdb_ext;

  # load gtfs feeds into gtfsdb
  for f in ${GTFS_DIR}/*gtfs.zip
  do
    name=$(feed_name_from_zip $f)

    cmd="poetry run gtfsdb-load -c -ct -g -d $ott_url -s ${name} ${f}"
    echo $cmd
    eval $cmd
    sleep 1
  done

  cmd="poetry run update-shared-stops -s ${required_feed} -d $ott_url ott/gtfsdb/ext/shared_stops/data/shared_stops.csv"
  echo $cmd
  eval $cmd
  cd -
  echo; echo;

  # load gtfs feeds into gtfsdb
  for f in ${GTFS_DIR}/*gtfs.zip
  do
    name=$(feed_name_from_zip $f)
    dump="$pg_dump $db -n ${name} > ${GTFS_DIR}/${name}.sql"
    echo $dump
    eval $dump
  done
  echo; echo;

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
  echo "WARN: not loading as file $chk *does not* exist."
fi
