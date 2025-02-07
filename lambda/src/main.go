package main

import (
	"context"
	"encoding/json"
	"errors"
	"net/http"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type Request struct {
	Name string `json:"name"`
}

func (r *Request) Validate() error {
	if r.Name == "" {
		return errors.New("error: invalid request. name is required")
	}
	return nil
}

type Response struct {
	Message string `json:"message"`
}

func newLambdaResponse(msg string, statusCode int) (events.APIGatewayProxyResponse, error) {
	response := Response{
		Message: msg,
	}
	body, _ := json.Marshal(response)

	return events.APIGatewayProxyResponse{
		StatusCode: statusCode,
		Headers: map[string]string{
			"Content-Type": "application/json",
		},
		Body: string(body),
	}, nil
}

func handler(ctx context.Context, req Request) (events.APIGatewayProxyResponse, error) {
	if err := req.Validate(); err != nil {
		return newLambdaResponse(err.Error(), http.StatusBadRequest)
	}

	return newLambdaResponse("Hello "+req.Name+" from Lambda!", http.StatusOK)
}

func main() {
	lambda.Start(handler)
}
