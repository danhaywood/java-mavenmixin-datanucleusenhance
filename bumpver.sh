VERSION=$1

if [ ! "$VERSION" ]; then
    echo "usage: $(basename $0) [version]"
    exit 1
fi

# edit mixin's pom.xml
echo "editing mixin's pom.xml"
pushd mixin >/dev/null
mvn versions:set -DnewVersion=$VERSION > /dev/null
popd >/dev/null

echo "Committing changes"
git commit -am "bumping to $VERSION"

# tag if not a snapshot
echo $VERSION | grep -v SNAPSHOT > /dev/null
if [ $? = 0 ]; then
    echo "tagging (not a snapshot version)"
    git tag $VERSION
fi
