##
## load gtfsdb spatial db for OTT
## *note*: requires the ott db to exist 
##
LDDIR=`dirname $0`
. $LDDIR/../base.sh


# poetry install
gtfs_load="poetry run gtfsdb-load"
install_load=`which gtfsdb-load`
if [ $install_load ]; then
  echo "Will use the installed '$install_load' rather than running via poetry."
  gtfs_load=$install_load
fi

# loader install (prefer that over poetry)
if [ -f "bin/gtfsdb-load" ]; then
  gtfs_load="bin/gtfsdb-load"
fi

for f in ${GTFS_DIR}/*gtfs.zip
do
  name=$(feed_name_from_zip $f)
  if [ ${2:-""} == "f" ]; then
    if [ ${name} == "trimet" ] || [ ${name} == "ctran" ]; then
      continue;
    fi
  fi

  cmd="$gtfs_load -c -ct -g -d $ott_url -s ${name} ${f}"
  echo $cmd
  if [ ${1:-""} == "load" ]; then
    echo loading...
    eval $cmd
  fi
done
