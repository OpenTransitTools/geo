##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/../base.sh

# put loader's bin dir here
ln -s ~/rtp/loader/bin . > /dev/null 2>&1

FEEDS_DIR="$HOME/gtfs/cache"
for f in ${FEEDS_DIR}/*gtfs.zip
do
  # rename '../AGENCY_NAME.gtfs.zip' to 'agency_name' 
  name=${f#$FEEDS_DIR/}
  name=${name%.gtfs.zip}
  name=${name,,}

  cmd="bin/gtfsdb-load -c -ct -g -d $otp_url -s ${name} ${f}"
  echo $cmd
  eval $cmd

  sleep 1

  dump="$pg_dump $db -n ${name} > ${FEEDS_DIR}/${name}.sql"
  echo $dump
  eval $dump
  
  echo; echo;
done
