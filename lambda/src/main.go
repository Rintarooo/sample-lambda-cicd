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

func newLambdaResponse(body string, statusCode int) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{
		StatusCode: statusCode,
		Headers: map[string]string{
			"Content-Type": "application/json",
		},
		Body: body,
	}, nil
}

func handler(ctx context.Context, req Request) (events.APIGatewayProxyResponse, error) {
	if err := req.Validate(); err != nil {
		return newLambdaResponse(err.Error(), http.StatusBadRequest)
	}

	response := Response{
		Message: "Hello " + req.Name + " from Lambda!",
	}

	body, err := json.Marshal(response)
	if err != nil {
		return newLambdaResponse(err.Error(), http.StatusInternalServerError)
	}

	return newLambdaResponse(string(body), http.StatusOK)
}

func main() {
	lambda.Start(handler)
}
