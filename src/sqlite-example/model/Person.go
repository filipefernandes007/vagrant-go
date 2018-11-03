package model

type Person struct {
	Base
	FirstName string `json:"firstname"`
	LastName string `json:"lastname"`
	City string `json:"city"`
	Description string `json:"description"`
	Age uint
}

func NewPerson(firstname string, lastname string, city string, description string, age uint) *Person {
	return &Person{Base{UUID:GenerateUUID()},
		firstname,
		lastname,
		city,
		description,
		age}
}

