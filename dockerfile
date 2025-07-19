# Use official Node.js image
FROM node:18-alpine
COPY package*.json ./
RUN npm cache clean --force
RUN npm install

EXPOSE 8080
COPY . .
# Start the application
CMD ["npm", "start"]
