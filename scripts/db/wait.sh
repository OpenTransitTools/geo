#
# pg_isready - is db ready to talk?
#
WDIR=`dirname $0`
. $WDIR/../base.sh

count=${1:-10}
snooze=${2:-30}

for i in $(seq 1 $count)
do
  $WDIR/isready.sh > /dev/null 2> /dev/null
  s=$?
  if [ $s -lt 1 ]; then
    break
  fi
  cmd="sleep $snooze"
  echo $cmd ... waiting for db isready.sh
  eval $cmd
  let snooze=$(( snooze - count + 1 ));
  if [ $snooze -lt 1 ]; then
    snooze=30
  fi
done
