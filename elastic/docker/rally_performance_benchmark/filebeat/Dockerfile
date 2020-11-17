ARG ELK_VERSION
ARG ELK_USER
ARG ELK_PASSWORD

# https://www.docker.elastic.co/
FROM docker.elastic.co/beats/filebeat:${ELK_VERSION}

ENV ELK_USER=${ELK_USER}
ENV ELK_PASSWORD=${ELK_PASSWORD}
