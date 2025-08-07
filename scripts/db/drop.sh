##
## drop OTT database
##
DIR=`dirname $0`
. $DIR/../base.sh

cmd="$psql -d ${def_url} -c \"DROP DATABASE ${db};\""
echo $cmd
eval $cmd

cmd="$psql -d ${def_db} -c \"DROP USER ${user};\""
echo $cmd
eval $cmd
