FROM mongodb/mongodb-community-server

# ENV DEBIAN_FRONTEND=noninteractive
# RUN echo 'tzdata tzdata/Areas select Asia' | debconf-set-selections && \
#     echo 'tzdata tzdata/Zones/Asia select Colombo' | debconf-set-selections
# ENV DEBIAN_FRONTEND=dialog

WORKDIR /root

COPY bin/mongodb/indexes.js /docker-entrypoint-initdb.d/
COPY bin/mongodb/run-indexes.sh /docker-entrypoint-initdb.d/

