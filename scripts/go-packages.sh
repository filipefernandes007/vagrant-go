#!/usr/bin/env bash

echo "Installing go packages..."

go get -u github.com/EngineerKamesh/gofullstack/volume3/section4/gopherface/common/utility
go get -u github.com/gin-gonic/gin
go get -u github.com/go-sql-driver/mysql
go get -u github.com/jinzhu/gorm
go get -u github.com/jinzhu/gorm/dialects/mysql
go get -u github.com/jinzhu/gorm/dialects/sqlite
go get -u gopkg.in/gormigrate.v1
go get -u gopkg.in/yaml.v2
go get -u github.com/caarlos0/env

echo "Go packages Installed"
