package main

import (
	"context"
	runtime "github.com/aws/aws-lambda-go/lambda"
	utils "github.com/jhole89/aws-utils"
	framework "github.com/jhole89/orbital-framework"
	"github.com/jhole89/orbital-framework/database"
	"log"
	"os"
)

var (
	appSyncEvent utils.AppSyncEvent
	conf         framework.Config
)

func handleRequest(ctx context.Context, event interface{}) (interface{}, error) {

	if err := appSyncEvent.FromJson(event); err != nil {
		log.Println(err)
		return &framework.Entity{}, err
	}

	conf.Database = &framework.DatabaseConfig{
		Type:     "awsneptune",
		Endpoint: os.Getenv("ORBITAL_DB_ADDRESS"),
	}

	graph, err := database.GetGraph(conf.Database.Type, conf.Database.Endpoint)
	if err != nil {
		log.Println(err)
		graph.Close()
		return &framework.Entity{}, err
	}

	ent, err := graph.GetEntity(appSyncEvent.Arguments["id"])
	if err != nil {
		log.Println(err)
		graph.Close()
		return &framework.Entity{}, err
	}

	graph.Close()
	return &ent, nil
}

func main() {
	runtime.Start(handleRequest)
}
