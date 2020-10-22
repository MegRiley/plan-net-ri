FROM maven:3.6.3-jdk-11-slim AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app/pom.xml
RUN mvn -f /usr/src/app/pom.xml clean package

FROM jetty:9-jdk11-slim
COPY --from=build /usr/src/app/target/root.war /var/lib/jetty/webapps/root.war
USER jetty:jetty
EXPOSE 8080