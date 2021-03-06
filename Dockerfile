FROM java:openjdk-7-jdk
MAINTAINER support@mesosphere.io

# Update java settings so DNS changes take hold.
RUN grep '^networkaddress.cache.ttl=' /etc/java-7-openjdk/security/java.security || echo 'networkaddress.cache.ttl=60' >> /etc/java-7-openjdk/security/java.security

RUN \
    # Install zookeeper
    curl -Lo /tmp/zookeeper.tgz http://apache.osuosl.org/zookeeper/zookeeper-3.4.8/zookeeper-3.4.8.tar.gz \
    && mkdir -p /opt/zookeeper/transactions /opt/zookeeper/snapshots \
    && tar -xzf /tmp/zookeeper.tgz -C /opt/zookeeper --strip=1 \
    && rm /tmp/zookeeper.tgz \

    # Install exhibitor
    && curl -Lo /opt/exhibitor-1.5.6-all.jar http://downloads.mesosphere.io/exhibitor/exhibitor-1.5.6-all.jar

# Write out basic config
COPY exhibitor-wrapper /exhibitor-wrapper
CMD ["/exhibitor-wrapper"]
