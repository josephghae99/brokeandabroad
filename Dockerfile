FROM node:20 
#Add a work directory
WORKDIR /app
#Copy dependencies
COPY ./check.txt ./package*.json ./package-lock.json[t] ./yarn.lock[t] ./



#Install dependencies
RUN yarn install
#Copy app files
COPY . .
#Cache and Install dependencies



#.env Source destination argument
ARG source_file=./.env
ARG destination_dir=./.env

#.env copying management
RUN if [ -f "$source_file" ]; then \
        if [ "$source_file" != "$destination_dir" ]; then \
            echo "Copying $source_file to $destination_dir"; \
            cp "$source_file" "$destination_dir"; \
        else \
            echo "Source and destination paths are the same; skipping copy."; \
        fi \
    else \
        echo ".env has been added to dockerignore; skipping copy; if you want to copy it, remove it from dockerignore."; \
    fi



#Expose port
EXPOSE 3000 
#Build command

RUN yarn build 
#Start the app
CMD next build && next start --port 3000
