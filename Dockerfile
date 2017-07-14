FROM node:6.11.1

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# Set environment variables
ENV appDir /var/www/app/current

# Set the work directory
RUN mkdir -p /var/www/app/current
WORKDIR ${appDir}

# Add our package.json and install *before* adding our application files
ADD package.json ./
RUN npm install --production

# Install hexo *globally* so we can run our application
RUN npm install -g hexo

# Add application files
ADD . ${appDir}
RUN ["hexo", "generate"]

EXPOSE 15401
CMD ["npm", "start"]