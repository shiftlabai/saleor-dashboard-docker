# In the builder, we build the static assets for the dashboard, but with
# placeholders for the various environment variables. In the runtime container,
# we replace those placeholders with the environment variables configured at
# runtime.
FROM node:14 as builder
WORKDIR /app
COPY saleor-dashboard/package*.json ./
RUN npm install
COPY saleor-dashboard .
ENV API_URI __ENV_API_URI__
ENV APP_MOUNT_URI __ENV_APP_MOUNT_URI__
ENV STATIC_URL __ENV_STATIC_URL__
RUN STATIC_URL=${STATIC_URL} API_URI=${API_URI} APP_MOUNT_URI=${APP_MOUNT_URI} npm run build

FROM nginx:stable
WORKDIR /app
COPY saleor-dashboard/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build/ /app-raw/
COPY hydrate-env-vars.sh /docker-entrypoint.d/

ARG APP_MOUNT_URI
ARG API_URI
ARG STATIC_URL
ENV API_URI ${API_URI:-http://localhost:8000/graphql/}
ENV APP_MOUNT_URI ${APP_MOUNT_URI:-/dashboard/}
ENV STATIC_URL ${STATIC_URL:-/dashboard/}
