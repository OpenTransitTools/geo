if [ -d ~/gtfsdb/cache ]; then
  TAR_DIR=~/gtfsdb/cache
elif [ -d ~/gtfsdb ]; then
  TAR_DIR=~/gtfsdb
else
  TAR_DIR=~/gtfs
fi

db_url=$1
def_db=${2:-postgres}

docker_exe="docker exec -i -u $def_db"
psql="$docker_exe -it db psql"
pg_restore="$docker_exe db psql"
pg_dump="$docker_exe db pg_dump"

# IMPORTANT: there are are python configs for user, pass and db in loader/config/app.ini, which also need to change
user=ott
pass=ott
db=ott
osm_db=osm
otp_url=postgresql://$user:$pass@127.0.0.1:5432/$db

# use URL if we get content on the cmd line (default to docker url when no ://)
if  [[ "$db_url" != "" ]] && [[ "$db_url" != *"://"* ]]; then
    db_url=postgres://docker:docker@localhost:5432/
fi
