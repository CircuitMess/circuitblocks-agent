#!/bin/sh
goreleaser build --snapshot --rm-dist --id darwin

rm -r ./dist/CircuitBlocksAgent
mkdir -p ./dist/CircuitBlocksAgent.app/Contents/Resources
mkdir -p ./dist/CircuitBlocksAgent.app/Contents/MacOS

cp ./Info.plist ./dist/CircuitBlocksAgent.app/Contents/Info.plist
cp ./icon/icon.icns ./dist/CircuitBlocksAgent.app/Contents/Resources/icon.icns
cp ./dist/darwin_darwin_arm64/circuitblocks-agent ./dist/CircuitBlocksAgent.app/Contents/MacOS/circuitblocks-agent
cp ./config.ini ./dist/CircuitBlocksAgent.app/Contents/MacOS/config.ini

cd ./dist

create-dmg --dmg-title="CircuitBlocksAgent" --overwrite "CircuitBlocksAgent.app"
rm -rf ./CircuitBlocksAgent.app