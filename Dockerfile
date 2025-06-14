# Step 1: Build the Angular app
FROM node:18 AS build

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy project files and build the app
COPY . .
RUN npm run build --prod

# Step 2: Serve the app with NGINX
FROM nginx:alpine

# Copy built app to NGINX html directory
COPY --from=build /app/dist/* /usr/share/nginx/html/

# Optional: Custom NGINX config
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
