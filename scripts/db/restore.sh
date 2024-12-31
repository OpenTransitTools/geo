RESTDIR=`dirname $0`
. $RESTDIR/../base.sh

cd $GTFS_DIR
echo "LOADING db with files in $PWD"

function restore_file_types() {
  ext=${1:-"sql"}

  for x in *.${ext}
  do
    echo restore backup: $x
    r="$pg_restore -d ${db_url}${db} < $x"
    echo $r
    eval $r

    m="mv $x $x-processed"
    echo $m
    eval $m

    echo
  done
}

restore_file_types schema
restore_file_types sql
restore_file_types views

cd -
