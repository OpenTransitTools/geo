RESTDIR=`dirname $0`
. $RESTDIR/../base.sh


function restore_file_types() {
  ext=${1:-"sql"}
  do_move=${2:-"TRUE"}  

  for x in *.${ext}
  do
    echo restore backup: $x
    r="$pg_restore -d ${ott_url} < $x"
    echo $r
    eval $r

    if [ $do_move == "TRUE" ]; then
      m="mv $x $x-processed"
      echo $m
      eval $m
    fi
    echo
  done
}

cd $GTFS_DIR
echo "LOADING db with files in $PWD"
restore_file_types schema $1
restore_file_types sql $1
restore_file_types views $1
cd -
