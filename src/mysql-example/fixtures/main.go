package main

import (
	"fmt"
	"github.com/jinzhu/gorm"
	_ "github.com/go-sql-driver/mysql"
	"../datastore"
	"../model"
)

var db *gorm.DB
var err error

func main() {
	db, err := datastore.DB(datastore.MYSQL)

	if err != nil {
		fmt.Println(err)
	}

	defer db.Close()

	db.Model(&model.Person{}).ModifyColumn("description", "text")
	db.AutoMigrate(&model.Person{})

	p0 := model.NewPerson("Filipe","Fernandes", "Fundão", "", 46)
	p1 := model.Person{FirstName: "Jane", LastName: "Smith"}
	p2 := model.NewPerson("John","Doe", "NY", "", 51)
	db.Create(&p0)
	db.Create(&p1)
	db.Create(&p2)
}
