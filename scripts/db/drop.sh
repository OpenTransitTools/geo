##
## drop OTT database
##
DIR=`dirname $0`
. $DIR/../base.sh

cmd="$psql -d ${db_url}${def_db} -c \"DROP DATABASE ${db};\""
echo $cmd
eval $cmd

cmd="$psql -d ${db_url}${def_db} -c \"DROP USER ${user};\""
echo $cmd
eval $cmd

#cmd="$psql -d ${db_url}${def_db} -c \"DROP DATABASE ${osm_db};\";"
#echo $cmd
#eval $cmd
