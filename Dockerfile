# Container image that runs your code
FROM alpine:3.10

RUN apk add --no-cache bash openssh-client sshpass

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY src /src


# Code file to execute when the docker container starts up (`entrypoint.sh`)
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

## testing, keep alive
#ENTRYPOINT ["tail", "-f", "/dev/null"]

