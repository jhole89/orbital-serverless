package main

import (
	"context"
	"encoding/json"
	"fmt"
	runtime "github.com/aws/aws-lambda-go/lambda"
	framework "github.com/jhole89/orbital-framework"
	"github.com/jhole89/orbital-framework/database"
	"log"
	"os"
)

type admin struct {
	Command string `json:"command"`
}

func (a *admin) fromJson(s string) error {
	return json.Unmarshal([]byte(s), &a)
}

var (
	conf     framework.Config
	adminMsg admin
)

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

	//log.Printf("event: event%v\n", event)

	//for _, msg := range event.Records {
	//	if err = adminMsg.fromJson(msg.Body); err != nil {
	//		log.Printf("Unable to unmarshall: %s", err)
	//		return nil, err
	//	}
	//	if adminMsg.Command == "rebuild" {
	if err = framework.ReIndex(graph, conf.Lakes); err != nil {
		log.Println(err)
		graph.Close()
		return nil, err
	}
	graph.Close()
	return "started", nil
	//	} else {
	//		errMsg := fmt.Sprintf("unknown Command [%s] found in Body", adminMsg.Command)
	//		log.Println(errMsg)
	//		return nil, fmt.Errorf(errMsg)
	//	}
	//}
	//return nil, nil
}

func main() {
	runtime.Start(handleRequest)
}
