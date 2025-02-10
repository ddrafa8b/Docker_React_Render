FROM node:18 AS builder

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias e instalar
COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

# Copiar el resto del código fuente y construir la aplicación
COPY . .
RUN npm run build

# Fase final: Servir con Nginx
FROM nginx:alpine

# Copiar los archivos construidos al directorio de Nginx
COPY --from=builder /app/build /usr/share/nginx/html

# Exponer el puerto 80 para servir la aplicación
EXPOSE 80

# Comando por defecto para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]

