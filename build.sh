#!/bin/bash
CYAN='\033[0;36m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' 

#
# - json helper
#
function jsonval {
    temp=`echo $json    |       \
    sed 's/\\\\\//\//g' |       \
    sed 's/[{}]//g'     |       \
    awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | \
    sed 's/\"\:\"/\|/g' |       \
    sed 's/[\,]/ /g'    |       \
    sed 's/\"//g'       |       \
    grep -w $prop       |       \
    cut -d":" -f2       |       \
    sed -e 's/^ *//g' -e 's/ *$//g'`
    echo ${temp##*|}
}

json=`cat docker/"$1".json`

#
# - extract tag and image
#
prop="image"
IMAGE=`jsonval`
TAG=`git name-rev --name-only HEAD`

#
# - extract dockerfile
#
prop="dockerfile"
DOCKERFILE=`jsonval`

# = build the thing
docker build -t "$IMAGE:$TAG" -f docker/"$DOCKERFILE" .
