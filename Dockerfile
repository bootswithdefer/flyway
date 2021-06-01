FROM amazoncorretto:11-alpine

# Add the flyway user and step in the directory
RUN adduser -D -u 1000 jenkins

WORKDIR /flyway
ENV FLYWAY_VERSION 7.9.1

RUN apk add --no-cache curl bash \
  && curl -L https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz -o flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz --strip-components=1 \
  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && chown -R jenkins:jenkins /flyway
  
ENV PATH="/flyway:${PATH}"

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
