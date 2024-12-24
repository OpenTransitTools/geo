DIR=`dirname $0`
. $DIR/../base.sh

f=rail.sql
curl http://maps6.trimet.org/data/$f > ~/gtfs/$f
