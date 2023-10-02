# nginx-proxy

Nginx reverse proxy docker container for app deploying

### Get started

Used location to use nginx-proxy is: `/root`

The configuration file is located in `config/config.txt`. You can use `config/config.example.txt` as a basis.

Once pulled the repo to `/root` folder, configure domain forwarding by editing `config/config.txt` file. After that you can start using nginx-proxy by running `update.sh` manually.

```
bash /root/nginx-proxy/update.sh
```

### Configure crontab to auto update certifications

Set up cron:

```
bash /root/nginx-proxy/setup-cron.sh
```

You can find `scripts/cron-file` in project folder. Write your schedules in that file. By default auto update time is 1 st and 15 th day of every months.

**Note:** After editing/changing the cron-file, **re-run** setup cron command!

### Add a certificate for a domain

```bash
docker-compose run certbot /scripts/get-certs
```

### Forwarding to another IP

By default, the `scripts/http.conf` and `scripts/https.conf` configuration files uses the IP address 127.0.0.1.
If you need to make a proxy to another location, then this IP address can be changed.
