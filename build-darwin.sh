#!/bin/sh
goreleaser build --snapshot --rm-dist --id darwin

mkdir -p ./dist/CircuitBlocksAgent.app/Contents/Resources
mkdir -p ./dist/CircuitBlocksAgent.app/Contents/MacOS

cp ./Info.plist ./dist/CircuitBlocksAgent.app/Contents/Info.plist
cp ./icon/icon.icns ./dist/CircuitBlocksAgent.app/Contents/Resources/icon.icns
cp ./dist/darwin_darwin_amd64_v1/circuitblocks-agent ./dist/CircuitBlocksAgent.app/Contents/MacOS/circuitblocks-agent
cp ./config.ini ./dist/CircuitBlocksAgent.app/Contents/MacOS/config.ini

# for this to work, credentials need to be stored in keychain

#  xcrun notarytool store-credentials circuitblocks
#                --apple-id "albert@circuitmess.com"
#                --team-id KLW4LV446H
#                --password <app_id_password>

cd ./dist
codesign --deep --force --options=runtime --sign "1CF7C6C4A31BA61D9F4C5E3D97C53157CA13C26C" --timestamp ./CircuitBlocksAgent.app
create-dmg --overwrite "CircuitBlocksAgent.app"
mv ./CircuitBlocksAgent\ 1.0.64.dmg ./CircuitblocksAagent-osx.dmg
xcrun notarytool submit ./CircuitblocksAagent-osx.dmg --keychain-profile circuitblocks --wait