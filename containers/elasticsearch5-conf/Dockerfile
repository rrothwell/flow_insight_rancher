FROM busybox
MAINTAINER richard.rothwell@aarnet.edu.au

ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /confd
RUN chmod +x /confd

ADD ./conf.d /etc/confd/conf.d
ADD ./templates /etc/confd/templates
ADD ./run.sh /run.sh
ADD ./dockerentry.sh /dockerentry.sh
ADD ./jvm.options /jvm.options

VOLUME /data/confd
VOLUME /opt/rancher/bin
VOLUME /usr/share/elasticsearch/config


# Busybox specific stuff.
# No home directory, no password.
RUN addgroup -g 5000 elasticsearch && adduser -H -D -u 5000 -G elasticsearch elasticsearch

ENTRYPOINT ["/dockerentry.sh"]
CMD ["--backend", "rancher", "--prefix", "/2015-07-25"]
