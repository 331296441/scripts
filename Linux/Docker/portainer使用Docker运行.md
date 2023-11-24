

# server
```
docker run -d --name=Portainer --restart=unless-stopped -p 9000:9000/tcp -v /volume2/docker/portainer/data:/data -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer-ce
```

# agent
```
docker run -d \
  -p 9001:9001 \
  --name portainer_agent \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /volume2/docker/portainer/volumes:/var/lib/docker/volumes \
  portainer/agent
 ```