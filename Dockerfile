FROM springio/gs-spring-boot-docker

ENV GLOWROOT_VERSION 0.10.12

ADD https://github.com/glowroot/glowroot/releases/download/v$GLOWROOT_VERSION/glowroot-$GLOWROOT_VERSION-dist.zip /

RUN unzip glowroot-$GLOWROOT_VERSION-dist.zip \
    && rm glowroot-$GLOWROOT_VERSION-dist.zip

COPY admin.json /glowroot/

ENTRYPOINT ["java", "-javaagent:/glowroot/glowroot.jar", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]
