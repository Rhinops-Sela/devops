FROM blancahot/fennec-base:develop


#ENV
ENV COMPONENTS_ROOT=/app/components
ENV WORKING_ROOT=/app/working_folder
ENV MAIN_TEMPLATE_FORM=fennec/fennec_ui_components/forms/development-form.json
ENV FORM_TEMPLATES_FOLDER=fennec/fennec_ui_components/templates
ENV AWS_ACCESS_KEY_ID=1
ENV AWS_SECRET_ACCESS_KEY=1
ENV AWS_DEFAULT_REGION=eu-west-2

# add webclient
COPY nginx.conf /etc/nginx/nginx.conf
COPY webclient/wizard /usr/share/nginx/html


# add backend
COPY backend/. /app/backend/.
RUN chmod +x /app/backend/node_modules/pm2/bin/pm2

#add components
COPY components/. /app/.

#install fennec module
RUN cd $COMPONENTS_ROOT \
  && ls \
  && pip3 install $COMPONENTS_ROOT/fennec/ 

#Exposing node port	
EXPOSE 3000
EXPOSE 9090

CMD ["sh", "-c","/app/backend/node_modules/pm2/bin/pm2 start /app/backend/dist/src/index.js && nginx -g \"daemon off;\""]
