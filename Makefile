# `make version=0.1.0 tag`
version := 0.0.0-SNAPSHOT
author  := Circuitmess
app     := Circuitblocks Agent
id      := com.circuitmess.cb-agent

install:
	go get -u ./... && go mod tidy
	which appify || go get github.com/machinebox/appify
	which create-dmg || npm i -g create-dmg
	which goreleaser || curl -sfL https://install.goreleaser.com/github.com/goreleaser/goreleaser.sh | sh

build-win:
	goreleaser build --snapshot --rm-dist --id windows

build-darwin:
	goreleaser build --snapshot --rm-dist --id darwin

build-linux:
	goreleaser build --snapshot --rm-dist --id linux
