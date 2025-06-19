GEODIR=`dirname $0`
. $GEODIR/../base.sh

LAYERS=${1:-"ott:current ott:current_flex ott:current_routes ott:current_stops"}
SERVERS=${2:-"http://localhost:8600"}

function cache_clear() {
  layer=$1
  mach=${2:-"http://localhost:8600"}
  cmd="curl -u $gs_user:$gs_password -H \"Content-type: text/xml\" -X POST -d \"<truncateLayer><layerName>$layer</layerName></truncateLayer>\"  \"$mach/geoserver/gwc/rest/masstruncate\""
  echo " $layer cache clear:"
  echo " $cmd"
  eval $cmd
  echo
}

echo "CLEAR GeoWebCache layers: $LAYERS"
echo
for s in $SERVERS
do
  for l in $LAYERS
  do
    cache_clear $l $s
  done
done
echo
