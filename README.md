# nginx-proxy

Nginx reverse proxy docker container for app deploying

Конфигурационный файл размещается в `config/config.txt`. За основу можно взять `config/config.example.txt`

### Добавить сертификат для домена

```bash
docker-compose run certbot /scripts/get-certs
```

### Переадресация на другой IP

По умолчанию в файлах конфигурации `scripts/http.conf` и `scripts/http.conf` используется IP-адрес 127.0.0.1.
Если необходимо сделать прокси в другое место, то этот IP-адрес можно поменять.
