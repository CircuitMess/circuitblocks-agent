package main

import (
	"log"
	"time"
)

type BufferflowDummypause struct {
	Name     string
	Port     string
	NumLines int
	Paused   bool
}

func (b *BufferflowDummypause) Init() {
}

func (b *BufferflowDummypause) BlockUntilReady() {
	log.Printf("BlockUntilReady() start. numLines:%v\n", b.NumLines)
	log.Printf("buffer:%v\n", b)
	//for b.Paused {
	log.Println("We are paused. Yeilding send.")
	time.Sleep(3000 * time.Millisecond)
	//}
	log.Printf("BlockUntilReady() end\n")
}

func (b *BufferflowDummypause) OnIncomingData(data string) {
	log.Printf("OnIncomingData() start. data:%v\n", data)
	b.NumLines++
	//time.Sleep(3000 * time.Millisecond)
	log.Printf("OnIncomingData() end. numLines:%v\n", b.NumLines)
}
