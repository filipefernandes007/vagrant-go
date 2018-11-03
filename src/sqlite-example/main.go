package main

import (
	_peopleController "./controllers/people"
	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
)

func main() {
	r := gin.Default()
	_peopleController.Init(r)
	r.Run(":8086")
}
