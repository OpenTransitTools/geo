if [ -d ~/gtfs/cache ]; then
  GTFS_DIR=~/gtfs/cache
elif [ -d ~/gtfsdb/cache ]; then
  GTFS_DIR=~/gtfsdb/cache
elif [ -d ~/gtfsdb ]; then
  GTFS_DIR=~/gtfsdb
else
  GTFS_DIR=~/gtfs
fi

db_url=$1
def_db=${2:-"postgres"}

docker_exe="docker exec -i -u $def_db"
psql=${psql:-"$docker_exe -it db psql"}
pg_restore=${pg_restore:-"$docker_exe db psql"}
pg_dump=${pg_dump:-"$docker_exe db pg_dump"}


# IMPORTANT: there are are python configs for user, pass and db in loader/config/app.ini, which also need to change
user=ott
pass=ott
db=ott
osm_db=osm
otp_url=postgresql://$user:$pass@127.0.0.1:5432/$db
db_view="~/geo/gs_sql_view.txt"


# use URL if we get content on the cmd line (default to docker url when no ://)
if  [[ "$db_url" != "" ]] && [[ "$db_url" != *"://"* ]]; then
    db_url=postgres://docker:docker@localhost:5432/
fi


function feed_name_from_zip() {
  # get lowercase feed name from gtfs .zip file name
  # ala '../FEED_NAME.gtfs.zip' -> 'feed_name' 
  name=${1#$FEEDS_DIR/}
  name=${name%.gtfs.zip}
  name=$(echo "$name" | awk '{print tolower($1)}')
  echo $name
}

