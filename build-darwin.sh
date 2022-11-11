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
#                --apple-id "email@email.com"
#                --team-id KLW4LV446H
#                --password <app_id_password>

cd ./dist
codesign --deep --force --options=runtime --sign "1CF7C6C4A31BA61D9F4C5E3D97C53157CA13C26C" --timestamp ./CircuitBlocksAgent.app
# create-dmg --overwrite "CircuitBlocksAgent.app"
# mv ./CircuitBlocksAgent\ 1.0.64.dmg ./CircuitBlocksAgent-osx.dmg
# xcrun notarytool submit ./CircuitBlocksAgent-osx.dmg --keychain-profile circuitblocks --wait
mkdir ./scripts
mkdir ./payload
mkdir ./payload/Applications
mkdir ./payload/Library
mkdir ./payload/Library/LaunchAgents
mv ./CircuitBlocksAgent.app ./payload/Applications
cp ../pkg-assets/postinstall ./scripts/postinstall
cp ../pkg-assets/CircuitBlocksAgent.plist ./payload/Library/LaunchAgents
cp ../pkg-assets/pkg-installer.plist ./pkg-installer.plist
chmod +x ./scripts/postinstall
pkgbuild --root ./payload --ownership preserve --identifier com.circuitmess.pkg.CircuitBlocksAgent --component-plist pkg-installer.plist --scripts scripts --sign "010471773D206582CE44C296760B8E01FA57C8EC" ./circuitblocks-agent.pkg
productsign --sign "87B75286D0D0D8C205B28BC29ADEFAB0AE9DD903" ./circuitblocks-agent.pkg ./circuitblocks-agent-signed.pkg
xcrun notarytool submit ./circuitblocks-agent-signed.pkg --keychain-profile circuitblocks --wait
