FROM node:12.2.0

# add app
COPY webclient/. /app/webclient/.
RUN chmod 775 /app/webclient/node_modules/.bin/ng
COPY backend/. /app/backend/.
COPY components/. /app/components/.
