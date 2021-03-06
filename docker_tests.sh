source .env_test
docker-compose up -d
docker exec -it cbg_redismanager_1 /bin/bash -c 'yes yes | ./redis-trib.rb create --replicas 0 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002'
docker exec cbg_redis1_1 redis-cli -c -p 7000 flushall
docker exec cbg_main_1 py.test -v --cov=cbg --cov-config .coveragerc cbg/tests/
