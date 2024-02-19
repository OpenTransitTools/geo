TAR_DIR=~/gtfsdb/cache/

db_url=$1
def_db=${2:-postgres}

psql="docker exec -u $def_db -it db psql"
pg_restore="docker exec -i -u $def_db db pg_restore"

# IMPORTANT: there are are python configs for user, pass and db in loader/config/app.ini, which also need to change
user=ott
pass=ott
db=ott
osm_db=osm

# use URL if we get content on the cmd line (default to docker url when no ://)
if  [[ "$db_url" != "" ]] && [[ "$db_url" != *"://"* ]]; then
    db_url=postgres://docker:docker@localhost:5432/
fi
