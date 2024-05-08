BLUE_STAG="cs-st-mapapp01"
GREEN_STAG="rj-st-mapapp01"

export MACHINES=${1-"$BLUE_STAG $GREEN_STAG"}
export LOAD_BALANCER="web_ws-trimet-org@rj-st-pubweb01"

TMP=/tmp/gs_machines
rm -rf $TMP
unset UPDATE

bolt command run "~/scripts/blue-green_toggle status geoserver" --target $LOAD_BALANCER > $TMP
cat $TMP
#export UPDATE=${1-"$BLUE_STAG"}
