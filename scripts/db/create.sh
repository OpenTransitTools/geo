##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/../base.sh

## create user (default is user='ott' with pass='ott' -- change in ./base.sh)
cmd="$psql -c \"CREATE USER ${user} WITH PASSWORD '${pass}';\""
echo $cmd
eval $cmd

# create ott DB (and formally osm $osm_db)
for d in $db 
do
  $psql -c "CREATE DATABASE ${d} WITH OWNER ${user};"
  $psql $d -c "CREATE EXTENSION postgis;"
done
