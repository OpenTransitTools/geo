DIR=`dirname $0`
. $DIR/base.sh

TAR_DIR=~/gtfsdb/cache/
for x in *-did_scp
do
  echo $x 
  mv $x ${x%%-did_scp}
done
