#!/bin/sh
# vim: sts=4 sw=4 et
jvm=hotspot
java=14
while getopts 'h9v:' c; do
    case $c in
        h)
            echo "usage: ${0} [-9] [-v VERSION]"
            echo "\t-9:\t\tbuild for OpenJ9"
            echo "\t-v VERSION:\tuse java VERSION"
            exit
            ;;
        9) jvm=openj9;;
        v) java=$OPTARG;;
    esac
done
build_dir=$(realpath $(dirname "$0"))
patch_dir="${build_dir}/patch"
mkdir $patch_dir 2>/dev/null
cd $patch_dir || exit $?
code=$(curl \
    -z paperclip.jar \
    -o paperclip.jar \
    -w %{http_code} \
    'https://papermc.io/api/v1/paper/1.15.2/latest/download') \
    || exit $?
if [ $code != "304" ]; then
    java -jar paperclip.jar
    mv cache/patched_*.jar "${build_dir}/paperspigot.jar"
fi
cd $build_dir
exec docker build \
    -t "flatulation/minecraft:${java}-${jvm}" \
    -t "flatulation/minecraft:latest" \
    --build-arg java=$java \
    --build-arg jvm=$jvm \
    .
