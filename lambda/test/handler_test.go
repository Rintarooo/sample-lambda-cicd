package test

import (
	"bytes"
	"encoding/json"
	"net/http"
	"testing"

	"github.com/aws/aws-lambda-go/events"
)

type Request struct {
	Name string `json:"name"`
}

func TestHandler(t *testing.T) {
	tests := []struct {
		name           string
		request        Request
		wantStatusCode int
	}{
		{
			name: "Success: valid request",
			request: Request{
				Name: "Test-san",
			},
			wantStatusCode: http.StatusOK,
		},
		{
			name: "Failure: invalid request. Name is empty",
			request: Request{
				Name: "",
			},
			wantStatusCode: http.StatusBadRequest,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			jsonBytes, err := json.Marshal(tt.request)
			if err != nil {
				t.Fatalf("failed to marshal request: %v", err)
			}

			resp, err := http.Post(
				"http://localhost:9000/2015-03-31/functions/function/invocations",
				"application/json",
				bytes.NewBuffer(jsonBytes),
			)
			if err != nil {
				t.Fatalf("failed to send request: %v", err)
			}
			defer resp.Body.Close()

			var lambdaResp events.APIGatewayProxyResponse
			if err := json.NewDecoder(resp.Body).Decode(&lambdaResp); err != nil {
				t.Fatalf("failed to decode response: %v", err)
			}

			if lambdaResp.StatusCode != tt.wantStatusCode {
				t.Errorf("status code = %v, want %v", lambdaResp.StatusCode, tt.wantStatusCode)
			}
		})
	}
}
