SHDIR=`dirname $0`
. $SHDIR/../base.sh

f=rail.sql
curl http://maps6.trimet.org/data/$f > ~/gtfs/$f
