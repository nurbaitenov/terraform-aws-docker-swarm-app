# terraform-aws-docker-swarm-app

### Instruction

1) Check manager node EC2 in shell (docker swarm should be active)
```
docker --version
docker info 
```

2) Run 
```
docker swarm join-token worker
```
3) Go to each the 2 EC2 worker nodes and run
```
sudo docker swarm join \
  --token <worker-token> \
  <manager-private-ip>:2377
```
4) 
```

```