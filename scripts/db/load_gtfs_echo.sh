##
## load gtfsdb spatial db for OTT
## *note*: requires the ott db to exist 
##
LDDIR=`dirname $0`
. $LDDIR/../base.sh

for f in ${GTFS_DIR}/*gtfs.zip
do
  name=$(feed_name_from_zip $f)  

  cmd="bin/gtfsdb-load -c -ct -g -d $otp_url -s ${name} ${f}"
  echo $cmd
  #eval $cmd
done
