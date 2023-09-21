FROM openjdk:17-alpine
ENTRYPOINT ["/usr/bin/backstage-public-test-service.sh"]

COPY backstage-public-test-service.sh /usr/bin/backstage-public-test-service.sh
COPY target/backstage-public-test-service-0.0.1-SNAPSHOT.jar /usr/share/backstage-public-test-service/backstage-public-test-service.jar
