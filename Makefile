# Borrowed from:
# https://github.com/silven/go-example/blob/master/Makefile
# https://vic.demuzere.be/articles/golang-makefile-crosscompile/

BINARY = cachet-monitor
GOARCH = amd64

VERSION=1.0
COMMIT=$(shell git rev-parse HEAD)
BRANCH=$(shell git rev-parse --abbrev-ref HEAD)

OUTPUT_DIR=./bin

# Setup the -ldflags option for go build here, interpolate the variable values
LDFLAGS = -ldflags "-X main.VERSION=${VERSION} -X main.COMMIT=${COMMIT} -X main.BRANCH=${BRANCH}"

# Build the project
all: clean linux darwin docker

linux:
	GOOS=linux GOARCH=${GOARCH} go build ${LDFLAGS} -o ${OUTPUT_DIR}/${BINARY}-linux-${GOARCH} .

darwin:
	GOOS=darwin GOARCH=${GOARCH} go build ${LDFLAGS} -o ${OUTPUT_DIR}/${BINARY}-darwin-${GOARCH} .

fmt:
	go fmt $$(go list ./... | grep -v /vendor/)

clean:
	-rm -f ${BINARY}-*

.PHONY: linux darwin fmt clean