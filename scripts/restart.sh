date
rm -f ~/geo/*/nohup.out

cd ~/geo/geoserver
docker-compose down; sleep 2

cd ~/geo/postgis
docker-compose down; sleep 5


docker network prune -f


echo $PWD
nohup docker-compose up &
sleep 2

cd ~/geo/geoserver
echo $PWD
nohup docker-compose up &
