FROM debian:buster

RUN apt-get update
RUN apt-get install -y postgresql-client

RUN apt-get install -y wget
RUN wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update; \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y aspnetcore-runtime-3.1

COPY commands/ /usr/bin/
RUN chmod +x /usr/bin/*


RUN mkdir /opt/fsesexe
COPY fsesexe /opt/fsesexe
RUN ls -l /opt
RUN ls -l /opt/fsesexe
RUN chmod +x /opt/fsesexe/fsesexe
RUN ln -s /opt/fsesexe/fsesexe /usr/bin/fsesexe 

# Configure supervisord
RUN apt-get install -y supervisor
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
