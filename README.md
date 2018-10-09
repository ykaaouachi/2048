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
Step 1/7 : FROM alpine:3.8
 ---> 196d12cf6ab1
Step 2/7 : MAINTAINER Youssef KAAOUACHI<ykaaouachi@gmail.com>
 ---> Running in b65970636b79
Removing intermediate container b65970636b79
 ---> 7fd6242bb64b
Step 3/7 : RUN apk --update add nginx &&     rm -rf /var/cache/apk/* &&     mkdir -p /run/nginx
 ---> Running in b0e9e307609e
fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/community/x86_64/APKINDEX.tar.gz
(1/2) Installing pcre (8.42-r0)
(2/2) Installing nginx (1.14.0-r1)
Executing nginx-1.14.0-r1.pre-install
Executing busybox-1.28.4-r1.trigger
OK: 6 MiB in 15 packages
Removing intermediate container b0e9e307609e
 ---> 37bf463bf975
Step 4/7 : COPY conf/nginx/nginx-nobody-user.conf /etc/nginx/nginx.conf
 ---> 7b57694b6705
Step 5/7 : COPY 2048 /usr/share/nginx/html
 ---> 43c7cff1f909
Step 6/7 : EXPOSE 80
 ---> Running in e64258fe11ab
Removing intermediate container e64258fe11ab
 ---> 9393507939bd
Step 7/7 : CMD ["nginx", "-g", "daemon off;"]
 ---> Running in c9ad7f24642e
Removing intermediate container c9ad7f24642e
 ---> 04673c51cdde
Successfully built 04673c51cdde
Successfully tagged ykaaouachi/2048:alpine-3.8-nginx
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
docker ps
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
