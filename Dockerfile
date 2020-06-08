FROM nginx:1.19.0-alpine

# add app
COPY webclient/wizard/. /usr/share/nginx/html/

#COPY backend/. /app/backend/.
#COPY components/. /app/components/.
#Docker
#AWS CLI
#helm
#ekscli
#kubectl
#tolerations
