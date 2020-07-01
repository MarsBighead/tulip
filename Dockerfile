FROM golang:1.14.4 as builder
RUN apt-get install \
            make \
            --assume-yes
RUN mkdir -p /go/src/tulip/.git

ADD main.go go.mod go.sum /go/src/tulip/
COPY method /go/src/tulip/method

# China mainland
ENV GOPROXY="https://goproxy.cn"
ENV GOSUMDB="sum.golang.google.cn"

ENV GO111MODULE=on
RUN ls /go/src/tulip
RUN go env
# RUN go mod verify

RUN (cd /go/src/tulip && go mod download) 
RUN (cd /go/src/tulip && go build) 


FROM centos:7.8.2003
RUN yum -y install \
           gcc \
           tree \
           make \
           rpm-build
RUN mkdir -p /opt/tulip
COPY --from=builder /go/src/tulip/tulip /opt/tulip/
ADD config.yaml /opt/tulip/