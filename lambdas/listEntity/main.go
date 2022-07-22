package main

import (
	runtime "github.com/aws/aws-lambda-go/lambda"
	framework "github.com/jhole89/orbital-framework"
	"github.com/jhole89/orbital-framework/database"
	"log"
	"os"
)

var (
	conf framework.Config
)

func handleRequest() (interface{}, error) {

	conf.Database = &framework.DatabaseConfig{
		Type:     "awsneptune",
		Endpoint: os.Getenv("ORBITAL_DB_ADDRESS"),
	}

	graph, err := database.GetGraph(conf.Database.Type, conf.Database.Endpoint)
	if err != nil {
		log.Println(err)
		graph.Close()
		return []*framework.Entity{}, err
	}

	entities, err := graph.ListEntities()
	if err != nil {
		log.Println(err)
		graph.Close()
		return &entities, err
	}

	graph.Close()
	return &entities, nil
}

func main() {
	runtime.Start(handleRequest)
}
