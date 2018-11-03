package model

import (
	"fmt"
	"github.com/jinzhu/gorm"
	"log"
	"os"
)

type Base struct {
	gorm.Model
	//ID uint `json:"id"`
	UUID string `json:"uuid"`
}

func GenerateUUID() string {
	f, err := os.Open("/dev/urandom")
	if err != nil {
		log.Println("Encountered the following error when attempting to generate an UUID: ", err)
		return ""
	}
	b := make([]byte, 16)
	f.Read(b)
	f.Close()
	uuid := fmt.Sprintf("%x-%x-%x-%x-%x", b[0:4], b[4:6], b[6:8], b[8:10], b[10:])
	return uuid
}
