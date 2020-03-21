#!/usr/bin/env bash

(
set -e
basedir="$(cd "$1" && pwd -P)"
workdir="$basedir/Tuinity/Paper/work"
mcver=$(cat "$workdir/BuildData/info.json" | grep minecraftVersion | cut -d '"' -f 4)
servettjar="$basedir/Servett-Server/target/servett-$mcver.jar"
vanillajar="$workdir/Minecraft/$mcver/$mcver.jar"

(
    cd "$basedir/Paperclip"
    mvn clean package "-Dmcver=$mcver" "-Dpaperjar=$servettjar" "-Dvanillajar=$vanillajar"
)
cp "$basedir/Paperclip/assembly/target/paperclip-${mcver}.jar" "$basedir/servettclip.jar"

echo ""
echo ""
echo ""
echo "Build success!"
echo "Copied final jar to $(cd "$basedir" && pwd -P)/servettclip.jar"
) || exit 1
