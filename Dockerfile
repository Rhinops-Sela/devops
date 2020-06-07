FROM node:12.2.0

# add app
COPY build-workspace/webclient/. /app/webclient/.
COPY build-workspace/backend/. /app/backend/.
