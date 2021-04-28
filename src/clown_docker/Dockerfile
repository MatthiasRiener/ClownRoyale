FROM jboss/keycloak:latest
LABEL maintainer="Matts und Luks"
COPY ./imports/realm/realm-export.json /tmp/realm-export.json
ENV KEYCLOAK_USER=clownadmin KEYCLOAK_PASSWORD=afrocircus KEYCLOAK_IMPORT="/tmp/realm-export.json -Dkeycloak.profile.feature.upload_scripts=enabled -Dkeycloak.migration.strategy=OVERWRITE_EXISTING"
