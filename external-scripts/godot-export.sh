#!/bin/bash
#
# Automatically export Godot to itch.io
# by lapspider45
# License: CC0
#
# This is a script for automatically exporting your godot project and pushing it to itch.io
# Edit it according to your needs
# Requires:
# * butler (https://itchio.itch.io/butler)
# * the correct export templates for your Godot version
# * your godot project is setup with export presets matching these names:
#   * auto-web
#   * auto-windows
#   * auto-linux
#
# EDIT THESE VARS BEFORE USING:

project_name='gwj-28'                       # the name for your executable files
butler='~/.config/itch/apps/butler/butler'  # path to your butler binary
project='..'                                # where your project is located
exportdir='../../export/'                   # where to put the exports
itch_page='lapspider45/gwj28'               # identifier for your itch page, see butler docs


# This does the exporting

cd "$exportdir"
godot --path "$project" --export "auto-web" "$exportdir/$project_name.html"
mv "$project_name.html" index.html
mkdir html5
mv favicon.png  $project_name.js  $project_name.pck  $project_name.png  $project_name.wasm  index.html html5/

sleep 2

godot --path "$project" --export "auto-windows" "$exportdir/$project_name.exe"
mkdir windows
mv $project_name.exe $project_name.pck windows/

sleep 2

godot --path "$project" --export "auto-linux" "$exportdir/$project_name.x86_64"
mkdir linux
mv $project_name.x86_64 $project_name.pck linux/

sleep 2

# Now, use butler to push all the builds

# during rating period, comment out as this is too dangerous
$butler push html5/ $itch_page:html5-postjam
$butler push windows/ $itch_page:windows-postjam
$butler push linux/ $itch_page:linux-postjam
