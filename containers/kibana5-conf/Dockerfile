FROM busybox
MAINTAINER richard.rothwell@aarnet.edu.au

# Set up confd to build config files from the provided templates 
# merged with values queried from the Rancher metadata store.
ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /confd
RUN chmod +x /confd
ADD ./conf.d /etc/confd/conf.d
ADD ./templates /etc/confd/templates

# Put in place the entry point script for the kibana-conf container.
# This runs confd.
ADD ./dockerentry.sh /dockerentry.sh

# Put in place the replacement entry point script for the base Kibana container.
# This will be executed by docker-compose.yml as provided by the Rancher template.
ADD ./run.sh /run.sh

VOLUME /data/confd
VOLUME /opt/rancher/bin
VOLUME /usr/share/kibana/config

# Busybox specific stuff.
# No home directory, no password.
RUN addgroup -g 5001 kibana && adduser -H -D -u 5001 -G kibana kibana


# Build the config files on container startup.
ENTRYPOINT ["/dockerentry.sh"]
CMD ["--backend", "rancher", "--prefix", "/2015-07-25"]

EXPOSE 5601

