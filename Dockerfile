FROM asinduvg/essemblyx-scala

#install coursier
WORKDIR /
RUN curl -fL "https://github.com/VirtusLab/coursier-m1/releases/latest/download/cs-aarch64-pc-linux.gz" | gzip -d > cs && \
    chmod +x cs && yes | ./cs setup
WORKDIR /root

# install nvm and pnpm
ENV NVM_DIR /root/.nvm
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install --lts && nvm use default && npm i -g pnpm && corepack enable

# install redis
RUN apt install redis-server -y

# install mongo db and start mongo service and create database indexes
ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'tzdata tzdata/Areas select Asia' | debconf-set-selections && \
    echo 'tzdata tzdata/Zones/Asia select Colombo' | debconf-set-selections
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor && \
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list && \
    apt-get update && apt-get install -y mongodb-org && mkdir -p /data/db
ENV DEBIAN_FRONTEND=dialog

COPY . lila/
    
# mongosh mongodb://localhost:27017/lichess < lila/bin/mongodb/indexes.js 

# ui/build --> build client

