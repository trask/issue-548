FROM springio/gs-spring-boot-docker

ENV GLOWROOT_VERSION 0.13.2-SNAPSHOT

ADD https://oss.sonatype.org/service/local/artifact/maven/redirect?r=snapshots&g=org.glowroot&a=glowroot-agent&c=dist&e=zip&v=$GLOWROOT_VERSION /glowroot-$GLOWROOT_VERSION-dist.zip

RUN unzip glowroot-$GLOWROOT_VERSION-dist.zip \
    && rm glowroot-$GLOWROOT_VERSION-dist.zip \
    && rm glowroot/lib/glowroot-embedded-collector.jar \
    && rm glowroot/lib/glowroot-central-collector-https-linux.jar \
    && rm glowroot/lib/glowroot-central-collector-https-windows.jar \
    && rm glowroot/lib/glowroot-central-collector-https-osx.jar

COPY admin.json /glowroot/
COPY glowroot.logback.xml /glowroot/
COPY glowroot.properties /glowroot/

ENTRYPOINT ["java", "-javaagent:/glowroot/glowroot.jar", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]
