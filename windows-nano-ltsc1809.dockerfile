# docker hub: https://hub.docker.com/_/golang
# github: https://github.com/docker-library/golang/blob/master/1.18/windows/nanoserver-1809/Dockerfile

# build stage
# FROM golang:nanoserver-ltsc2022 AS build-env
FROM golang:nanoserver-1809 AS build-env
LABEL maintainer="dev@jpillora.com"
ENV CGO_ENABLED 0
ENV GOOS=windows
ENV GOARCH=amd64
ADD . /src
WORKDIR /src
RUN go build \
    -ldflags "-X github.com/jpillora/chisel/share.BuildVersion=1.7.7" \
    -o chisel
# container stage
FROM mcr.microsoft.com/windows/nanoserver:1809
WORKDIR /app
COPY --from=build-env /src/chisel /app/chisel
ENTRYPOINT ["/app/chisel"]
