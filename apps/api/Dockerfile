FROM docker.io/node:lts-alpine

# Set working directory
WORKDIR /app

# Copy package.json files for dependency installation
# This might be in different locations depending on your build
COPY dist/apps/api/package*.json ./

# Copy the entire built application
COPY dist/apps/api/ ./

RUN npm install

# Start the application
CMD ["node", "main.js"]