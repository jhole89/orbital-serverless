package main

import (
	"context"
	"fmt"
	runtime "github.com/aws/aws-lambda-go/lambda"
	framework "github.com/jhole89/orbital-framework"
	"github.com/jhole89/orbital-framework/database"
	"log"
	"os"
)

var (
	conf framework.Config
)

type Response struct {
	Message string `json:"message"`
}

func handleRequest(ctx context.Context) (interface{}, error) {

	conf.Database = &framework.DatabaseConfig{
		Type:     "awsneptune",
		Endpoint: os.Getenv("ORBITAL_DB_ADDRESS"),
	}

	conf.Lakes = append(conf.Lakes, &framework.LakeConfig{
		Provider: "aws",
		Store:    "athena",
		Address:  fmt.Sprintf("db=default&region=us-west-2&output_location=%s", os.Getenv("RESULTS_BUCKET")),
	})

	graph, err := database.GetGraph(conf.Database.Type, conf.Database.Endpoint)
	if err != nil {
		log.Println(err)
		graph.Close()
		return nil, err
	}

	if err = framework.ReIndex(graph, conf.Lakes); err != nil {
		log.Println(err)
		graph.Close()
		return nil, err
	}
	graph.Close()
	return Response{Message: "Finished"}, nil
}

func main() {
	runtime.Start(handleRequest)
}
