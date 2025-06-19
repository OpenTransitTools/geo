if [ -d ~/gtfs/cache ]; then
  GTFS_DIR=~/gtfs/cache
elif [ -d ~/gtfsdb/cache ]; then
  GTFS_DIR=~/gtfsdb/cache
elif [ -d ~/gtfs ]; then
  GTFS_DIR=~/gtfs
else
  GTFS_DIR=~/gtfsdb
fi

GDIR=~/geo
PG_DIR=$GDIR/postgis
GS_DIR=$GDIR/geoserver
GS_LOG=$GDIR/gs.log

db_url=$1  # *note* this is really strange to have cmd line options here
def_db=${2:-"postgres"}


# IMPORTANT: there are are python configs for user, pass and db in loader/config/app.ini, which also need to change
user=ott
pass=ott
db=ott
osm_db=osm
ott_url=postgresql://$user:$pass@127.0.0.1:5432/$db

gs_user="admin"
gs_password="geoserver"

docker_exe="docker exec -i -u $def_db"
psql_term=${psql:-"$docker_exe -it db psql"}
psql_ott=${psql:-"$docker_exe -e PGUSER=$user -e PGPASSWORD=$pass db psql"}
psql=${psql:-"$docker_exe db psql"}
pg_isready=${pg_isready:-"$docker_exe db pg_isready"}
pg_restore=${pg_restore:-"$docker_exe db psql"}
pg_dump=${pg_dump:-"$docker_exe db pg_dump"}
pg_shp=${pg_shp:-"$docker_exe db shp2pgsql"}


# use URL if we get content on the cmd line (default to docker url when no ://)
if  [[ "$db_url" != "" ]] && [[ "$db_url" != *"://"* ]]; then
    db_url=postgres://docker:docker@localhost:5432/
fi


function feed_name_from_zip() {
  # get lowercase feed name from gtfs .zip file name
  # ala '../FEED_NAME.gtfs.zip' -> 'feed_name' 
  name=${1#$GTFS_DIR/}
  name=${name%.gtfs.zip}
  name=${name%.sql*}
  name=$(echo "$name" | awk '{print tolower($1)}')
  echo $name
}
