#
# pg_isready - is db ready to talk?
#
WDIR=`dirname $0`
. $WDIR/../base.sh

count=${1:-10}
snooze=${2:-20}

for i in $(seq 1 $count)
do
  # check if db is ready to use
  sleep 1
  $WDIR/isready.sh > /dev/null 2> /dev/null
  s=$?
  if [ $s -lt 1 ]; then
    break
  fi

  # sleep for a bit
  cmd="sleep $snooze"
  echo $cmd ... waiting for db isready.sh
  eval $cmd

  # decrease the snooze values
  let snooze=$(( snooze - count + 1 ));
  if [ $snooze -lt 1 ]; then
    snooze=20
  fi
done
