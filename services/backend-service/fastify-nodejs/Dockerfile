FROM node:14

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./
COPY src/server.js /usr/src/app/
# Install app dependencies
RUN npm install

# Bundle app source
COPY . .

# Expose port
EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]