#
# clone subdirs from a tree
# https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository/52269934#52269934
#
BRANCH="${1:-DEC_2025}"
DIRS="${2:-data_dir}"
NAME="geoserver_data_dir"
URL="https://github.com/OpenTransitTools/${NAME}.git"

rm -rf $DIRS $NAME
git clone -n --depth=1 --filter=tree:0 -b $BRANCH --single-branch $URL
cd $NAME
git sparse-checkout set --no-cone $DIRS
git checkout
mv $DIRS ../
cd ..
rm -rf $NAME
