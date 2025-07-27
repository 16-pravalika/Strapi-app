# Use Node.js official image
FROM node:18

# Set working directory
WORKDIR /app/

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

RUN npm install
# Copy the rest of the application
COPY . .

# Build Strapi admin panel
RUN npm run build

# Expose default Strapi port
EXPOSE 1337

# Start the Strapi app
CMD ["npm", "run", "start"]
