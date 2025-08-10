#!/bin/bash
systemctl stop redis-server
cd ../
mkdir redis_env
cd redis_env
echo "services:
  redis-prod:
    image: redis:7
    container_name: redis_prod
    ports:
      - \"6379:6379\"
    volumes:
      - redis_prod_data:/data
    command: [\"redis-server\", \"--appendonly\", \"yes\"]
  
  redis-dev:
    image: redis:7
    container_name: redis_dev
    ports:
      - \"6380:6379\"
    volumes:
      - redis_dev_data:/data
    command: [\"redis-server\", \"--appendonly\", \"no\"]
volumes:
  redis_prod_data:
  redis_dev_data:" > docker-compose.yml
docker compose up -d
cd ../install
