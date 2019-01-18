# CTFd Docker image

[![Build Status](https://travis-ci.org/toolisticon/ctfd-docker.svg?branch=master)](https://travis-ci.org/toolisticon/ctfd-docker)
[![Build Status](https://jenkins.holisticon.de/buildStatus/icon?job=toolisticon/ctfd-docker/master)](https://jenkins.holisticon.de/blue/organizations/jenkins/toolisticon%2Fctfd-docker/branches/)
[![Docker Build Status](https://img.shields.io/docker/build/toolisticon/ctf.svg)](https://hub.docker.com/r/toolisticon/ctf/)
[![Docker Stars](https://img.shields.io/docker/stars/toolisticon/ctf.svg)](https://hub.docker.com/r/toolisticon/ctf/)
[![Docker Pulls](https://img.shields.io/docker/pulls/toolisticon/ctf.svg)](https://hub.docker.com/r/toolisticon/ctf/)

> Production ready CTFd Docker image

# Deployment

You can set CTFd to a subpath, e.g /ctfd

Just add an environment variable during booting this image
```
SERVER_ROOT=/ctf
```

And now you can use nginx to proxy:

```
location /ctf/ {
     proxy_set_header Host $host;
     proxy_set_header X-Real-IP $remote_addr;
     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
     proxy_set_header X-Scheme $scheme;
     proxy_set_header X-Script-Name /ctf;
     proxy_pass http://127.0.0.1:8000;
 }
 ```
