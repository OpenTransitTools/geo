##
## load gtfsdb spatial db for OTT
## *note*: requires the ott db to exist 
##
LDDIR=`dirname $0`
. $LDDIR/../base.sh

gtfs_load="poetry run gtfsdb-load"
if [ -f "bin/gtfsdb-load" ]; then
  gtfs_load="bin/gtfsdb-load"
fi

for f in ${GTFS_DIR}/*gtfs.zip
do
  name=$(feed_name_from_zip $f)  

  cmd="$gtfs_load -c -ct -g -d $otp_url -s ${name} ${f}"
  echo $cmd
  #eval $cmd
done
