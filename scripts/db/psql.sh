##
## crete OTT spatial db for OTT
##
DIR=`dirname $0`
. $DIR/../base.sh

sql_cmd=${1:-"INTERACTIVE"}

if [ "$sql_cmd" == "INTERACTIVE" ]; then
  cmd="$psql_term $db"
else
  cmd="$psql_ott -h 127.0.0.1 -c '$sql_cmd'"
  echo $cmd
  eval $cmd
fi
