FROM alpine:3.8

LABEL version="1.0.0" \
      maintainer="Youssef KAAOUACHI<ykaaouachi@gmail.com>" \ 
      description="Image based on alpine v3.8, to run 2048 app on nginx"

ARG APP_PATH=/usr/share/nginx/html

    ## Install nginx.
RUN apk --update add nginx && \
    ## Remove cache to have minimal image.
    rm -rf /var/cache/apk/* && \
    ## Create /run/nginx because this directory does not exist 
    ## on the latest alpine containers.
    mkdir -p /run/nginx 

COPY conf/nginx/nginx-nobody-user.conf /etc/nginx/nginx.conf
COPY 2048 ${APP_PATH}

EXPOSE 80

# root user run nginx master process
# nobody user run nginx worker process (see conf/nginx/nginx-nobody-user.conf)
# Run this command "ps aux | grep -i nginx | grep -v grep" to check ;) 
CMD ["nginx", "-g", "daemon off;"]
