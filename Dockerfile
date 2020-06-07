FROM node:12.2.0

# add app
COPY webclient/. /app/webclient/.
COPY backend/. /app/backend/.
