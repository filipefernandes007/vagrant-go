# Vagrant 16.04 LTS Ubuntu Golang web development

### We will install :

* [Golang](https://golang.org) latest stable
* [Nginx](https://nginx.org/en/) (maybe for reverse proxy...)
* [Mysql](https://dev.mysql.com/downloads/mysql/5.7.html) 5.7
* [Sqlite3](https://sqlite.org/index.html)
* [MongoDB](https://www.mongodb.com/download-center) 4.0
* [Elasticsearch](https://www.elastic.co/products/elasticsearch) 6.4.2
* Java 8
* [Redis](https://redis.io) latest stable
* [Nodejs](https://nodejs.org) latest
* Go examples with [gorm](http://gorm.io)
* [Glide](https://glide.readthedocs.io/en/latest) to manage Go dependencies

### Install

```
git clone 
cd vagrant-go
vagrant up
```

### Access your vagrant machine and apps folder:

```
vagrant ssh
cd src
```

### Choose what to install

In config/config.yml you can decide what to be installed 
in your virtual machine. Choose _true_ for the dependencies you like to
be installed.

### Apps folder

Your applications live in `` /home/vagrant/src ``

### GO environment variables

GOPATH environment variable points to `` /home/vagrant ``

GOROOT environment variable points to `` /usr/lib/go ``

GOBIN environment variable points to ``  /home/vagrant/bin ``
 
### Examples

There are two examples that interact with database (_mysql_ and _sqlite_), both
depending on _gorm_, and _[gin](https://github.com/gin-gonic/gin)_ for routing. 
They are just examples, and are not ready for production.

If you want to play with them, first run migrations 
or then fixtures: 

``` 
cd src/<example>
```

```
go run migrations/main.go
go run fixtures/main.go 
```

Verify the results

```
go run main.go
```
[http://192.168.33.185:8085/people/](http://192.168.33.185:8085/people/)

For mysql you can use this credentials : *root:root*

Enjoy!