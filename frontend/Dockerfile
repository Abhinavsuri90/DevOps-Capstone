# SpendWise web UI. Build context: frontend/
#   docker build -t spendwise-frontend frontend
# Stage 1: build the static site with Node
FROM node:24-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund
COPY index.html vite.config.js ./
COPY src ./src
RUN npm run build

# Stage 2: serve it with nginx running as a non-root user (uid 101, port 8080)
FROM nginxinc/nginx-unprivileged:1.30.6-alpine
# Remove curl (not used at runtime; it carried CVE-2026-92392) and install Alpine's security fixes
# that are newer than the base image (brotli-libs, CVE-2026-111497), then drop back to uid 101.
USER root
RUN apk del --no-cache curl && apk upgrade --no-cache
USER 101
ENV BACKEND_HOST=backend \
    BACKEND_PORT=8000
COPY nginx.conf.template /etc/nginx/templates/default.conf.template
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080
