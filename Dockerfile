FROM debian:buster

RUN apt-get update
RUN apt-get install -y postgresql-client

COPY commands/ /usr/bin/
RUN chmod +x /usr/bin/*

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
