NAME="geoserver_data_dir"
URL="https://github.com/OpenTransitTools/${NAME}.git"
BRANCH="DEC_2025"
DIRS="data_dir"

rm -rf $DIRS $NAME
git clone -n --depth=1 --filter=tree:0 -b $BRANCH --single-branch $URL
cd $NAME
git sparse-checkout set --no-cone $DIRS
git checkout
mv $DIRS ../
cd ..
rm -rf $NAME
