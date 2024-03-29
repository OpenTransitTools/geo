date
rm -f ~/geo/*/nohup.out

cd ~/geo/geoserver
docker-compose down -v; sleep 2

cd ~/geo/postgis
docker-compose down -v; sleep 5

docker network prune -f; sleep 2


echo $PWD
nohup docker-compose up &
sleep 2

cd ~/geo/geoserver
echo $PWD
nohup docker-compose up &
