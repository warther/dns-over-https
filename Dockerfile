FROM golang:alpine AS builder
RUN apk add --no-cache git && \
    git clone https://github.com/m13253/dns-over-https && \
    cd dns-over-https && \
    go build -o doh-server

FROM alpine
COPY --from=builder /go/dns-over-https/doh-server /usr/local/bin/
CMD ["doh-server", "-conf", "/etc/dns-over-https/doh-server.conf"]
