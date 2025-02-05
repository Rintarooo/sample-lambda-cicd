package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

type Event struct {
	Name string `json:"name"`
}

type Response struct {
	Message string `json:"message"`
}

func handler(ctx context.Context, event Event) (Response, error) {
	return Response{
		Message: fmt.Sprintf("Hello %s from Lambda!", event.Name),
	}, nil
}

func main() {
	lambda.Start(handler)
}
