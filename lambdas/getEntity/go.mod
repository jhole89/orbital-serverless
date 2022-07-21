module github.com/jhole89/orbital-serverless/get-entity

go 1.17

require (
	github.com/aws/aws-lambda-go v1.27.0
	github.com/jhole89/aws-utils v1.0.0
	github.com/jhole89/orbital-framework v1.0.0
)

require (
	github.com/aws/aws-sdk-go v1.43.32 // indirect
	github.com/google/uuid v1.1.2 // indirect
	github.com/gorilla/websocket v1.4.2 // indirect
	github.com/jhole89/grammes v1.2.2 // indirect
	github.com/jmespath/go-jmespath v0.4.0 // indirect
	github.com/kr/text v0.2.0 // indirect
	github.com/segmentio/go-athena v0.0.0-20181208004937-dfa5f1818930 // indirect
	go.uber.org/atomic v1.4.0 // indirect
	go.uber.org/multierr v1.1.0 // indirect
	go.uber.org/zap v1.10.0 // indirect
	gopkg.in/yaml.v3 v3.0.0-20200615113413-eeeca48fe776 // indirect
)

replace (
	github.com/jhole89/aws-utils v1.0.0 => ../../aws_utils
	github.com/jhole89/orbital-framework v1.0.0 => ../../framework
)
