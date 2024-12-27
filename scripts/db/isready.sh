#
# pg_isready - is db ready to talk?
#
DIR=`dirname $0`
. $DIR/../base.sh

cmd="$pg_isready"
echo $cmd
eval $cmd
