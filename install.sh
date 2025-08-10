cd install
bash 1.add_docker_key
bash 2.add_docker_source  
bash 3.install_packages  
bash 4.configure_redis
bash 5.set_permissions
echo "DONE"
echo "Checking redis"
redis-cli -h 127.0.0.1 -p 6379 ping
redis-cli -h 127.0.0.1 -p 6380 ping

