# nginx-proxy

Nginx reverse proxy docker container for app deploying

Конфигурационный файл размещается в `config/config.txt`. За основу можно взять `config/config.example.txt`

### Добавить сертификат для домена

```bash
docker-compose run certbot /scripts/get-certs
```
