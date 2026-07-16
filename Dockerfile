#Build Stage
FROM golang:1.26-alpine AS builder

WORKDIR /app

COPY go.mod ./
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o myapp .
#Runtime Stage
FROM gcr.io/distroless/static-debian12:nonroot

WORKDIR /app

COPY --from=builder /app/myapp  .
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["/app/myapp"]

