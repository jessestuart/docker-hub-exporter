# ============
# Build phase.
# ============
ARG target
FROM golang:1.12-alpine as builder

RUN apk --update add ca-certificates && \
    apk --update add --virtual build-deps git musl-dev gcc

COPY . /go/src/github.com/infinityworks/docker-hub-exporter/

WORKDIR /go/src/github.com/infinityworks/docker-hub-exporter/cmd/exporter/

ARG goarch
ENV GOARCH $goarch
RUN go get && \
    GOOS=linux GOARCH=$GOARCH go build -o /exporter .

# ============
# Final phase.
# ============
FROM $target/alpine:3.9

COPY qemu-* /usr/bin/

EXPOSE 9170

RUN addgroup exporter && \
    adduser -S -G exporter exporter && \
    apk --update --no-cache add ca-certificates

COPY --from=builder /exporter /exporter

USER exporter

ENTRYPOINT ["/exporter"]
