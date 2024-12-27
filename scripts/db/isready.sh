#
# pg_isready - is db ready to talk?
#
IRDIR=`dirname $0`
. $IRDIR/../base.sh

cmd="$pg_isready"
echo $cmd
eval $cmd
