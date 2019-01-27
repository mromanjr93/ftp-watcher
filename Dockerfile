FROM ubuntu:14.04
MAINTAINER Emily Bache

ENV USER ftpuser
ENV PASS changeme

RUN apt-get update && \
    apt-get install -y vsftpd supervisor curl inotify-tools && \
    mkdir -p /var/run/vsftpd/empty && \
    mkdir -p /var/log/supervisord && \
    chmod -R 777 /var/log/supervisord

RUN mkdir -p /var/log/supervisor

COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
ADD scripts/watcher.sh /usr/local/bin/watcher.sh
ADD conf/vsftpd.conf /etc/vsftpd.conf

RUN chmod +x /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/watcher.sh

RUN mkdir /ftp

VOLUME ["/ftp"]

EXPOSE 20 21
EXPOSE 12020 12021 12022 12023 12024 12025

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]