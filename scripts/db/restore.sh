DIR=`dirname $0`
. $DIR/../base.sh

cd $TAR_DIR
echo $PWD

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
