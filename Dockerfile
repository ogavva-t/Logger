FROM debian:buster

RUN apt-get update
RUN apt-get install -y postgresql-client

COPY commands/ /usr/bin/
RUN chmod +x /usr/bin/*

# Configure supervisord
RUN apt-get install -y supervisor
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
