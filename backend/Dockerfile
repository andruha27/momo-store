# Start from golang base image
FROM golang:1.17 as builder

ARG VERSION=${VERSION}
LABEL name="momo-backend" \
      version=${VERSION}

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .


# Build the Go app
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o api ./cmd/api

######## Start a new stage from scratch #######
FROM alpine:latest

WORKDIR /root

RUN apk --no-cache add curl

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/api .

# Expose port 8081 to the outside world
EXPOSE 8081

# Command to run the executable
CMD ["./api"]
#CMD ["ls", "-la"]