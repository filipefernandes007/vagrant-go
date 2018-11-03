package main

import (
	"fmt"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
	"../datastore"
	"../model"
)

var db *gorm.DB
var err error

func main() {
	db, err = datastore.DB(datastore.SQLITE)

	if err != nil {
		fmt.Println(err)
	}

	defer db.Close()

	//db.AutoMigrate(&model.Person{})

	p0 := model.NewPerson("Filipe","Fernandes", "Fundão", "", 46)
	p1 := model.Person{FirstName: "Jane", LastName: "Smith"}
	p2 := model.NewPerson("John","Doe", "NY", "", 51)
	db.Create(&p1)
	db.Create(&p0)
	db.Create(&p2)
}
