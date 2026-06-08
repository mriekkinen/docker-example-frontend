FROM ubuntu

WORKDIR /app

RUN apt update \
  && apt install -y curl \
  && curl -L https://deb.nodesource.com/setup_16.x | bash \
  && apt install -y nodejs

RUN npm install -g serve

COPY package.json package-lock.json .
RUN npm install --production

COPY . .
ENV REACT_APP_BACKEND_URL=https://example-backend-tidy-comet-7555.fly.dev
RUN npm run build

EXPOSE 5001
CMD ["serve", "-s", "-l", "5001", "build"]
