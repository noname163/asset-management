FROM openjdk:11
EXPOSE 8080
ENV DB_URL=jdbc:postgresql://172.17.0.2:5432/AssetAssignmentDB
ENV DB_USERNAME=postgres
ENV DB_PASSWORD=admin
ENV ALLOWED_ORIGINS=http://host.docker.internal:3000
ENV JWT_SECRET_KEY=secret
ENV JWT_EXPIRES_TIME=10000
COPY . /app
ADD target/asset-management.jar /app/asset-management.jar
ENTRYPOINT ["java","-jar","/app/asset-management.jar"]

# FROM postgres:9.3
# ENV POSTGRES_USER postgres
# ENV POSTGRES_PASSWORD admin
# ENV POSTGRES_DB AssetAssignmentDB
# ADD script_backup_db.sql /docker-entrypoint-initdb.d/