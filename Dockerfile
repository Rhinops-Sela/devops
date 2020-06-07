# FROM node:12.2.0
FROM alpine

# add app
COPY webclient/. /app/webclient/.
COPY backend/. /app/backend/.
