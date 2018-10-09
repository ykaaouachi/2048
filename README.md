## Description

Small *image* (~6.44MB) based on `alpine` (version 3.8), to run `2048` app cloned from [Gabriel repo](https://github.com/gabrielecirulli/2048), with `nginx`.

### Dockerfile



### How to run

* **Step 1** : Clone repo

```
$ git clone git@github.com:ykaaouachi/2048.git
```

* **Step 2** : Build new image :construction:

```
$ cd /dir/repo/2048
$ docker build -t ykaaouachi/2048:v1.0-alpine.3.8-nginx .

Sending build context to Docker daemon  636.9kB
Step 1/9 : FROM alpine:3.8
 ---> 196d12cf6ab1
Step 2/9 : LABEL version="1.0.0"  maintainer="Youssef KAAOUACHI<ykaaouachi@gmail.com>"   description="Image based on alpine v3.8, to run 2048 app on nginx"
 ---> Using cache
 ---> 9891aa0e8bcc
Step 3/9 : ARG APP_PATH=/usr/share/nginx/html
 ---> Using cache
 ---> 63a024e7087f
Step 4/9 : RUN apk --update add nginx &&     rm -rf /var/cache/apk/* &&     mkdir -p /run/nginx
 ---> Using cache
 ---> e2775c71a5e7
Step 5/9 : COPY conf/nginx/nginx-nobody-user.conf /etc/nginx/nginx.conf
 ---> Using cache
 ---> b915e46a4851
Step 6/9 : COPY 2048 ${APP_PATH}
 ---> Using cache
 ---> faa8b21624f1
Step 7/9 : EXPOSE 80
 ---> Using cache
 ---> bfff85654851
Step 8/9 : HEALTHCHECK CMD /usr/bin/nc 127.0.0.1 80 < /dev/null || exit 1
 ---> Using cache
 ---> 99595e727daf
Step 9/9 : CMD ["nginx", "-g", "daemon off;"]
 ---> Using cache
 ---> a751a085e3f9
Successfully built a751a085e3f9
Successfully tagged ykaaouachi/2048:v1.0-alpine.3.8-nginx
Tagging alpine@sha256:8fe3a924c6d74fc9dfeabece9aff67f4481034bda815c8b9cad4964db084fbca as alpine:3.8
```

* **Step 3** : Sign your image (Docker best practice)
For security needs, add this env variable :
```
$ export DOCKER_CONTENT_TRUST=1
```
For more details : [docker documentation](https://docs.docker.com/engine/security/trust/content_trust/)

Now, to sign :bookmark_tabs: our image, use `docker trust sign` Docker command :
```
$ docker trust sign ykaaouachi/2048:v1.0-alpine.3.8-nginx
```


* **Step 4** : Run container :rocket:
```
$ docker run -d --name 2048 -p 8080:80 ykaaouachi/2048:v1.0-alpine.3.8-nginx
43551384f420c80283063864b8cdd160bce01d9e93e57d687175e8a9da097dd0
```

* **Step 5** : Check if everything is OK :vertical_traffic_light:

List running containers, we must see our container (`2048`) : 
```
$ docker ps 
```

And to check that `root` user *run nginx master process* & `nobody` user *run nginx worker process* : 
```
$ docker exec 2048 ps aux | grep -i nginx | grep -v grep
    1 root      0:00 nginx: master process nginx -g daemon off;
    6 nobody    0:00 nginx: worker process
```

* **Step 6** : Docker Health check

When run `docker ps`, we must see '(healthy)' on `STATUS` : 
```
$ docker ps
CONTAINER ID  IMAGE                                  ...  STATUS                  PORTS                NAMES
8dd6cea8a447  ykaaouachi/2048:v1.0-alpine.3.8-nginx  ...  Up 13 minutes (healthy) 0.0.0.0:8080->80/tcp 2048
```
* **Step 7** : Start game
- If you run Docker on host machine : Launch on your browser `http://localhost:8080/`
- If you use VM to run Docker : launch `http://<IP.ADDRESS.VM.MACHINE>:8080/`

### Destroy Docker object
* Remove 2048 container : 
```
$ docker kill 2048 && docker rm 2048
```

* Remove 2048 image
```
$ docker rmi ykaaouachi/2048:v1.0-alpine.3.8-nginx
```

### References

* Docker documentation, 
* [Content trust in Docker](https://docs.docker.com/v17.09/engine/security/trust/content_trust/),
* [Gabriel repo](https://github.com/gabrielecirulli/2048),
* [To fix some issues with nginx](https://superuser.com),
* ...
