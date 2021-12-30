# Sample dockerfile to build library and statically linked zipjail
#
# This can be built for the current platform via a command like:
#
#    docker build -t tracy-zipjail:latest .
#
FROM ubuntu:focal-20211006 as builder

RUN apt-get update && \
	apt-get install -y gcc build-essential

WORKDIR /src

COPY ./src/ ./

RUN make

WORKDIR /src/zipjail

RUN make

FROM ubuntu:focal-20211006

WORKDIR /app

COPY --from=builder /src/zipjail/zipjail /app/zipjail

# TODO Should run as non root

CMD [ "/app/zipjail" ]
