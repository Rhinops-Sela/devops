FROM nginx:1.19.0

#unzip
RUN apt update && \
    apt install unzip -y

#nodejs
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

#kubectl
RUN curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl

#eksctl
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp && \
    mv /tmp/eksctl /usr/local/bin

#tolerations

# add webclient
COPY webclient/wizard/. /usr/share/nginx/html/

# add backend
COPY backend/. /app/backend/.
RUN chmod +x /app/backend/node_modules/pm2/bin/pm2

#add components
COPY components/. /app/components/.

#Exposing node port	
EXPOSE 3000
EXPOSE 9090

CMD ["sh", "-c","/app/backend/node_modules/pm2/bin/pm2 start /app/backend/dist/index.js && nginx -g \"daemon off;\""]
