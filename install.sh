cd install
bash 1.add_docker_key.sh
bash 2.add_docker_source.sh  
bash 3.install_packages.sh
bash 4.configure_redis.sh
bash 5.set_permissions.sh
bash 6.create_nginx_site.sh
echo "DONE"
echo "Checking redis"
redis-cli -h 127.0.0.1 -p 6379 ping
redis-cli -h 127.0.0.1 -p 6380 ping

