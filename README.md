### Instrukcja instalacji środowiska
## Wymagania
1. Zainstalowany system linux

## Procedura instalacji
### Instalacja docker + redis
1. Dodaj oficjalny klucz GPG Dockera:
```
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```
2.  Dodaj repozytorium do Apt sources:
```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```
3. sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
4. apt-get install redis
5. Utwórz lokalizację środowiska redisa
  `mkdir redis_env`
6. W utworzonym katalogu przygotuj plik konfiguracyjny dockera
   `vim docker-compose.yml`
7. Wrzuć następującą zawartość do pliku
```version: '3.8'
services:
  redis-prod:
    image: redis:7
    container_name: redis_prod
    ports:
      - "6379:6379"
    volumes:
      - redis_prod_data:/data
    command: ["redis-server", "--appendonly", "yes"]

  redis-dev:
    image: redis:7
    container_name: redis_dev
    ports:
      - "6380:6379"
    volumes:
      - redis_dev_data:/data
    command: ["redis-server", "--appendonly", "no"]
volumes:
  redis_prod_data:
  redis_dev_data:
```
8. Uruchom kontenery redis
`docker compose up -d`
9. Sprawdź poprawność instalacji
    1. redis-cli -h 127.0.0.1 -p 6379 ping
    2. redis-cli -h 127.0.0.1 -p 6380 ping
   
   Powinieneś zobaczyć 2 razy odpowiedź PONG
### Instalacja zależności do projektu
1. apt-get install composer
2. apt install php-redis

### Zadbanie o prawidłowe uprawnienia
1. Katalog writable z repozytorium codeigniter musi mieć uprawnienia do zapisu

        chmod go+w writable/

   
