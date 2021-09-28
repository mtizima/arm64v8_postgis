FROM arm64v8/postgres:10-buster

LABEL maintainer="Dmitry Grebenshchikov <mtizima@gmail.com>"

ENV PG_MAJOR 10
ENV POSTGIS_MAJOR 2.5
ENV POSTGIS_VERSION 2.5.5+dfsg-1.pgdg100+2

RUN apt-get update \
      && apt-cache showpkg postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh
COPY ./update-postgis.sh /usr/local/bin
