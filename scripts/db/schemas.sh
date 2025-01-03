SCDIR=`dirname $0`
. $SCDIR/../base.sh

SCHEMAS=${1:-"current"}
PERMS=${2:-"ALL"}
USERS=${3:-"$user"}

for s in $SCHEMAS
do
  echo "DROP SCHEMA IF EXISTS $s CASCADE;" > $GTFS_DIR/$s.schema
  echo "CREATE SCHEMA $s;" >> $GTFS_DIR/$s.schema
  p="ALTER DEFAULT PRIVILEGES IN SCHEMA $s GRANT $PERMS"
  echo "$p ON TABLES TO $USERS;" >> $GTFS_DIR/$s.schema
  echo "$p ON SEQUENCES TO $USERS;" >> $GTFS_DIR/$s.schema
done
