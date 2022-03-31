FROM node:16

# Create app directory
WORKDIR /app
# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
RUN git clone https://github.com/kunalnagarco/imdb-scraper .

RUN npm install

#Prepare our image to run different commands depending on the enviroment
ARG NODE_ENV
RUN if [ "$NODE_ENV" = "development" ]; \
        then npm install; \
        else npm install --only=production; \
        fi

# Bundle app source
COPY . ./

# env variable port with default = 3000
ENV PORT 3000

# Port to send traffic on the container.
# Application (Node APP) listening on port 3000.
EXPOSE $PORT
# CMD ["npm", "run", "dev"] in production
CMD ["npm", "start"]
