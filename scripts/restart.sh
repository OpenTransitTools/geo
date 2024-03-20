cd ~/geo/geoserver
docker-compose down

cd ~/geo/postgis
docker-compose down

sleep 2
docker-compose up

cd ~/geo/geoserver
docker-compose up
