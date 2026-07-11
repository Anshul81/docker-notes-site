# Docker Learning Notes — static site served by Nginx
# Base image ships its own CMD (nginx -g "daemon off;") — inherited, not rewritten.

FROM nginx:alpine

# Nginx's default web root — must match exactly, it's hardcoded by the image maintainers.
COPY site/ /usr/share/nginx/html

EXPOSE 80
