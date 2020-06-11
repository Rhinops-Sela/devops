FROM noamasela/fennec-base:latest

# add webclient
COPY webclient/wizard/. /usr/share/nginx/html/
ENV FORM_TEMPLATE_FILE=../assets/assets/form/template.json

# add backend
COPY backend/. /app/backend/.
RUN chmod +x /app/backend/node_modules/pm2/bin/pm2

#add components
COPY components/. /app/components/.

#Exposing node port	
EXPOSE 3000
EXPOSE 9090

CMD ["sh", "-c","/app/backend/node_modules/pm2/bin/pm2 start /app/backend/dist/index.js && nginx -g \"daemon off;\""]
