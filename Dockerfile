FROM golang:1.11.4 as builder
RUN mkdir /build
ADD . /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -a -mod=vendor -ldflags '-s -w' .
FROM scratch
COPY --from=builder /build/dyndns53 /app/
WORKDIR /app
ENTRYPOINT ["./dyndns53"]