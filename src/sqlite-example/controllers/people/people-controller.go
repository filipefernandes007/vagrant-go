package PeopleController

import (
	"fmt"
	_dt "../../datastore"
	"../../model"
	"github.com/gin-gonic/gin"
)

type Env struct {
	env *_dt.Env
}

func Init(r *gin.Engine) {
	db, err := _dt.DB(_dt.SQLITE)

	if err != nil {
		fmt.Println(err)
	}

	defer db.Close()

	env := &Env{env: &_dt.Env{Db:db}}
	r.GET("/people/", env.GetPeople)
	r.GET("/people/:id", env.GetPerson)
	r.POST("/people", env.CreatePerson)
	r.PUT("/people/:id", env.UpdatePerson)
	r.DELETE("/people/:id", env.DeletePerson)
	r.Run(":8085")
}

func (e *Env) DeletePerson(c *gin.Context) {
	id := c.Params.ByName("id")
	var person model.Person
	d := e.env.Db.Where("id = ?", id).Delete(&person)
	fmt.Println(d)
	c.JSON(200, gin.H{"id #" + id: "deleted"})
}
func (e *Env) UpdatePerson(c *gin.Context) {
	var person model.Person
	id := c.Params.ByName("id")
	if err := e.env.Db.Where("id = ?", id).First(&person).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	}
	c.BindJSON(&person)
	e.env.Db.Save(&person)
	c.JSON(200, person)
}
func (e *Env) CreatePerson(c *gin.Context) {
	var person model.Person
	c.BindJSON(&person)
	e.env.Db.Create(&person)
	c.JSON(200, person)
}
func (e *Env) GetPerson(c *gin.Context) {
	id := c.Params.ByName("id")
	var person model.Person
	if err := e.env.Db.Where("id = ?", id).First(&person).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, person)
	}
}
func (e *Env) GetPeople(c *gin.Context) {
	var people []model.Person

	if err := e.env.Db.Find(&people).Error; err != nil {
		c.AbortWithStatus(404)
		fmt.Println(err)
	} else {
		c.JSON(200, people)
	}
}

