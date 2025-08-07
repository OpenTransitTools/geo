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

# IMPORTANT: there are are python configs for user, pass and db in loader/config/app.ini, which also need to change
user=${pg_user:-"ott"}
pass=${pg_pass:-"ott"}
port=${pg_port:-"5432"}
server=${server:-"127.0.0.1"}

db=${pg_db:-"ott"}
def_db=${def_db:-"postgres"}

ott_url=postgresql://$user:$pass@$server:$port/$db
def_url=postgresql://$user:$pass@$server:$port/$def_db

# docker'ized psql cmds
docker_exe="docker exec -i -u $def_user"
psql_term=${psql:-"$docker_exe -it db psql"}
psql_ott=${psql:-"$docker_exe -e PGUSER=$user -e PGPASSWORD=$pass db psql"}
psql=${psql:-"$docker_exe db psql"}
pg_isready=${pg_isready:-"$docker_exe db pg_isready"}
pg_restore=${pg_restore:-"$docker_exe db psql"}
pg_dump=${pg_dump:-"$docker_exe db pg_dump"}
pg_shp=${pg_shp:-"$docker_exe db shp2pgsql"}


gs_user=${gs_user:-"admin"}
gs_password=${gs_pass:-"geoserver"}


function feed_name_from_zip() {
  # get lowercase feed name from gtfs .zip file name
  # ala '../FEED_NAME.gtfs.zip' -> 'feed_name' 
  name=${1#$GTFS_DIR/}
  name=${name%.gtfs.zip}
  name=${name%.sql*}
  name=$(echo "$name" | awk '{print tolower($1)}')
  echo $name
}
