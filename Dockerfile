# image to build hugo /public and put it into nginx for serving website
FROM hugomods/hugo:dart-sass-go-git-0.147.8 AS builder

WORKDIR /src
COPY hugo/ .
RUN hugo build

# Stage 2
FROM nginx:1.27-alpine-slim
RUN rm -rf /usr/share/nginx/html/*
# Copy generated site from builder
COPY --from=builder /src/public /usr/share/nginx/html
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]