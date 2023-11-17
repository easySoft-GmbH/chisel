# docker hub: https://hub.docker.com/_/golang
# github: https://github.com/docker-library/golang/blob/master/1.18/windows/nanoserver-1809/Dockerfile

# build stage
FROM golang:nanoserver-1809 AS build
LABEL maintainer="dev@jpillora.com"
ENV CGO_ENABLED 0
ENV GOOS=windows
ENV GOARCH=amd64
ADD . /src
WORKDIR /src
RUN go build \
    -ldflags "-X github.com/jpillora/chisel/share.BuildVersion=1.9.1" \
    -o chisel
# container stage
FROM mcr.microsoft.com/windows/nanoserver:1809
# COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
WORKDIR /app
COPY --from=build /src/chisel /app/chisel
ENTRYPOINT ["/app/chisel"]
