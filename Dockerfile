# Use a Node.js base image (e.g., Node.js 18)
FROM node:16

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json (if exists)
COPY package*.json ./

# Install dependencies including eslint
RUN npm install
# RUN npm install --save-dev eslint@latest
# RUN npm install --save-dev eslint-plugin-node@latest


# Copy the rest of the application code into the container
COPY . .

# Expose the container port (optional, depending on your app)
EXPOSE 3000

# Start the application (or another command as needed)
CMD ["npm", "start"]
