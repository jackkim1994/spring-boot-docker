ARG MAVEN_IMAGE
ARG JRE_IMAGE

FROM ${MAVEN_IMAGE} AS build

WORKDIR /build

COPY ./pom.xml ./
COPY ./src ./src

RUN mvn clean package -DskipTests

FROM ${JRE_IMAGE}

WORKDIR /app

COPY --from=build /build/target/*.jar app.jar

EXPOSE 80

CMD ["java", "-jar", "app.jar"]