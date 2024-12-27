##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/../base.sh

sql_cmd=${1:-"INTERACTIVE"}

if [ $sql_cmd == "INTERACTIVE" ]; then
  $psql_term ott
else
  cmd="$psql ott -c '$sql_cmd'"
  echo $cmd
  eval $cmd
fi
