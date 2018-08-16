# TO BUILD: docker build -t subnetting .
# TO RUN  : docker run -it --rm subnetting

# Use a specific Alpine version
FROM alpine:3.5

# Set working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

RUN apk add --update bash \
    'python3<3.5.3' \
  && pip3 install subnetting \
  && rm -rf /var/cache/apk/*

ENTRYPOINT ["subnetting"]
