FROM node:20-bookworm-slim

ENV NODE_ENV=production
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV CHROME_PATH=/usr/bin/chromium

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  chromium \
  fonts-liberation \
  xauth \
  xvfb \
  libasound2 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libcups2 \
  libdrm2 \
  libgbm1 \
  libgtk-3-0 \
  libnss3 \
  libpango-1.0-0 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  libxshmfence1 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY . .

EXPOSE 10000

CMD ["xvfb-run", "-a", "--server-args=-screen 0 1366x900x24 -nolisten tcp -ac", "node", "index.js"]
