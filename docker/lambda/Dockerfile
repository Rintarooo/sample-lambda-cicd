# syntax=docker/dockerfile:1

ARG GO_VERSION=1.22.5 \
  GO_ARCH=arm64

FROM golang:${GO_VERSION}-alpine AS builder
WORKDIR /go/src/handler
COPY lambda/src/go.* ./
COPY lambda/src/*.go ./
RUN CGO_ENABLED=0 GOARCH=${GO_ARCH} go build -tags lambda.norpc -o /go/bin/handler

FROM public.ecr.aws/lambda/provided:al2023 AS runner
COPY --from=builder /go/bin/handler ./main
ENTRYPOINT [ "./main" ]

FROM runner AS runner-with-rie
ADD https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie /usr/bin/aws-lambda-rie
RUN chmod 755 /usr/bin/aws-lambda-rie
ENTRYPOINT [ "/usr/bin/aws-lambda-rie" ]
