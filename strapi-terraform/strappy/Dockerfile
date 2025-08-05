# Base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first (for caching install step)
COPY package.json yarn.lock ./

# Install dependencies
RUN npm install

# Copy rest of the project
COPY . .

# Build Strapi admin panel
RUN npm run build

# Expose default Strapi port
EXPOSE 1337

# Start the app
CMD ["npm", "start"]
