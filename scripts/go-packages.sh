#!/usr/bin/env bash

echo "Installing Go packages..."

GOPATH="/home/vagrant"

go get -u -v github.com/EngineerKamesh/gofullstack/volume3/section4/gopherface/common/utility
go get -u -v github.com/gin-gonic/gin
go get -u -v github.com/go-sql-driver/mysql
go get -u -v github.com/jinzhu/gorm
go get -u -v github.com/jinzhu/gorm/dialects/mysql
go get -u -v github.com/jinzhu/gorm/dialects/sqlite
go get -u -v gopkg.in/gormigrate.v1
go get -u -v gopkg.in/yaml.v2
go get -u -v github.com/caarlos0/env
go get -u -v github.com/derekparker/delve/cmd/dlv

echo "Go packages Installed"
