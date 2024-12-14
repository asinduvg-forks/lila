FROM node

# install nvm and pnpm
RUN nvm use default && npm i -g pnpm && corepack enable