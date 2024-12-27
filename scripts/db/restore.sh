RESTDIR=`dirname $0`
. $RESTDIR/../base.sh

cd $GTFS_DIR
echo "LOADING db with files in $PWD"

for x in ls *.sql
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

for x in ls *.views
do
  echo restore view: $x
  r="$RESTDIR/file.sh $x"
  echo $r
  eval $r

  m="mv $x $x-processed"
  echo $m
  eval $m

  echo
done
cd -
