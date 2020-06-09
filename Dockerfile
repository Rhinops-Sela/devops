FROM nginx:1.19.0

# add app
COPY webclient/wizard/. /usr/share/nginx/html/

# add backend
COPY backend/. /app/backend/.
RUN chmod +x /app/backend/node_modules/pm2/bin/pm2-docker

# add components
COPY components/. /app/components/.

#Unzip
RUN apt update && \
    apt install unzip

#Nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt install nodejs -y

#AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install
#helm
RUN curl https://get.helm.sh/helm-v3.2.2-linux-amd64.tar.gz -o helm-v3.2.2-linux-amd64.tar.gz && \
    tar -zxvf helm-v3.2.2-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm

#ekscli
#kubectl
#tolerations

CMD ["sh", "-c","/app/backend/node_modules/pm2/bin/pm2-docker start /app/backend/dist/index.js && nginx -g \"daemon off;\""]
