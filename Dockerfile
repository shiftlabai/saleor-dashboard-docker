# In the builder, we build the static assets for the dashboard, but with
# placeholders for the various environment variables. In the runtime container,
# we replace those placeholders with the environment variables configured at
# runtime.
FROM node:14 as builder
WORKDIR /app
COPY saleor-dashboard/package*.json ./
RUN npm install
COPY saleor-dashboard .
RUN STATIC_URL=__ENV_STATIC_URL__ \
  API_URI=__ENV_API_URI__ \
  APP_MOUNT_URI=__ENV_APP_MOUNT_URI__ \
  npm run build

FROM nginx:stable
WORKDIR /app
COPY saleor-dashboard/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build/ /app/

# Scripts in `/docker-entrypoint.d/` are run by ngins:stable at startup; see
# https://github.com/nginxinc/docker-nginx/blob/88018137053bdda23bd31fd61249b4b521eaffcf/entrypoint/docker-entrypoint.sh#L17∑
COPY hydrate-env-vars.sh /docker-entrypoint.d/

ARG APP_MOUNT_URI
ARG API_URI
ARG STATIC_URL
ENV API_URI ${API_URI:-http://localhost:8000/graphql/}
ENV APP_MOUNT_URI ${APP_MOUNT_URI:-/dashboard/}
ENV STATIC_URL ${STATIC_URL:-/dashboard/}
