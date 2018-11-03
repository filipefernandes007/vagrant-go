package datastore

import (
	"errors"
	"github.com/jinzhu/gorm"
	"github.com/joho/godotenv"
	"log"
	"os"
)

type Env struct {
	Db *gorm.DB
}

const (
	MYSQL = iota
	SQLITE
	MONGODB
	REDIS
)

func DB(datastoreType int) (*gorm.DB, error) {
	e := godotenv.Load(os.Getenv("GOPATH") + "/src/mysql-example/.env")

	if e != nil {
		log.Fatal("Error loading .env file")
	}

	host  		:= os.Getenv("mysql_database_host")
	port  		:= os.Getenv("mysql_database_port")
	mysqlDname  := os.Getenv("mysql_database_name")
	user  		:= os.Getenv("mysql_database_user")
	pwd   		:= os.Getenv("mysql_database_password")

	switch datastoreType {
		case MYSQL:
			return gorm.Open("mysql", user + ":" + pwd + "@tcp(" + host + ":" + port + ")/" +mysqlDname+ "?charset=utf8&parseTime=True&loc=Local")

		case SQLITE:
			sqliteFilePath := os.Getenv("GOPATH") + "/src/sqlite-example/data/"

			return gorm.Open("sqlite3", sqliteFilePath + os.Getenv("sqlite_database_file"))

		default:
			return nil, errors.New("The datastore you specified does not exist!")
	}
}