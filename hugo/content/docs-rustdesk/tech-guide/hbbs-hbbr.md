---
title: "HBBS и HBBR"
weight: 3
cascade:
  type: docs
---

HBBS (Signaling) - Компонент содержащий всю логику работы и дб<br>
HBBR (Relay) - Компонент регистрирующийся в hbbs (инициализация подключения идёт от hbbs) и выполняющий функцию пропускания трафика через себя при не установлении прямого подключения к ИМу.

## HBBS Deploy

```docker-compose {filename="docker-compose.yaml"}
services:
  nginx:
    image: nginx:alpine
    container_name: hbbs-nginx
    ports:
      - '443:443'      # HTTPS for web console
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx_ssl:/etc/nginx/ssl:ro
      - ./nginx_logs:/var/log/nginx
    restart: unless-stopped
    networks:
      - rustdesk-net
    sysctls:
      - net.ipv4.ip_forward=1
      - net.ipv4.conf.all.route_localnet=1
    extra_hosts:
      - "host.docker.internal:host-gateway"

  hbbs:
    image: docker.io/rustdesk/rustdesk-server-pro:1.6.2
    container_name: hbbs
    hostname: hbbs-msk2
    command: hbbs
    volumes:
      - ./hbbs_data:/root
    environment:
      # https://github.com/rustdesk/rustdesk-server/tree/master?tab=readme-ov-file#env-variables
      # IP address/DNS name of the machines running hbbr (separated by comma)
      - "RELAY=rustrelay-spb2-1.netsrv.pw"
      - "ENCRYPTED_ONLY=1"
      - "RUST_LOG=INFO"
    network_mode: host
    # ports:
    #   - '21114:21114/tcp' # HTTPS for web console
    #   - '21115:21115/tcp' # RustDesk NAT test
    #   - '21116:21116/tcp' # RustDesk hole punching (TCP)
    #   - '21116:21116/udp' # RustDesk registration and heartbeat service (UDP)
    #   - '21118:21118/tcp' # RustDesk web clients.
    restart: unless-stopped

networks:
  rustdesk-net:
    driver: bridge
    ipam:
      config:
        - subnet: 172.21.0.0/16
```

```nginx {filename="nginx.conf"}
events {
    worker_connections 1024;
}

http {

    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    sendfile on;
    keepalive_timeout 65;

    # Existing configuration for rustdesk.netsrv.pw
    server {
        listen 80;
        server_name rustdesk.netsrv.pw;
        return 301 https://$host$request_uri;
    }

    server {
        listen 443 ssl;
        http2 on;
        server_name rustdesk.netsrv.pw;

        # SSL Configuration
        ssl_certificate /etc/nginx/ssl/cert.pem;
        ssl_certificate_key /etc/nginx/ssl/private.key;
 
        # SSL Security Settings
        ssl_protocols TLSv1.2 TLSv1.3;
        ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA384';
        ssl_prefer_server_ciphers off;
        ssl_session_cache shared:SSL:10m;
        ssl_session_timeout 10m;

        set_real_ip_from 172.16.0.0/12;
        set_real_ip_from 10.0.0.0/8;
        set_real_ip_from 192.168.0.0/16;
        real_ip_header X-Forwarded-For;
        real_ip_recursive on;

        # Proxy to RustDesk web console
        location / {
            proxy_pass http://host.docker.internal:21114;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host $host;
            proxy_set_header X-Forwarded-Port $server_port;

            # Timeouts
            proxy_connect_timeout 60s;
            proxy_send_timeout 60s;
            proxy_read_timeout 60s;
        }

        # Proxy for WebSocket connection
        location /ws/id {
            proxy_pass http://host.docker.internal:21118;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "Upgrade";
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_read_timeout 120s;
        }

        access_log /var/log/nginx/rustdesk_access.log;
        error_log /var/log/nginx/rustdesk_error.log;
    }

}
```

Директория `hbbs_data` содержит в себе
* db.sqlite3, db.sqlite3-shm, db.sqlite3-wal — это файлы базы данных. Ваши аккаунты (включая пароли), логи и настройки хранятся в базе данных.

* id_ed25519 — приватный ключ. Этот файл важен, он используется на сервере RustDesk, без этого ключа невозможно восстановить публичный ключ. Ключ, который вы указываете на клиенте RustDesk (файл id_ed25519.pub), является публичным ключом. Вы также можете вручную задать приватный ключ (содержимое файла id_ed25519) через веб-консоль.

* oidc_config.toml - конфигурация клиента oidc.

### Лицензия

Проверка лицензии происходит при старте контейнера. Для её работы требуется `network_mode: host` либо спуфинг mac адреса контейнера (требуется docker-compose >v2)

```docker-compose
    networks:
      rustdesk-net:
        #license check bypass
        mac_address: a0:62:2f:7a:bc:1d
```

[Генерация мак адреса](https://rustdesk.com/docs/en/self-host/rustdesk-server-pro/installscript/docker/#docker-commands):
```
macaddrhbbs=$(echo -n A0-62-2F; dd bs=1 count=3 if=/dev/random 2>/dev/null |hexdump -v -e '/1 "-%02X"')
```



## HBBR Deploy

Нужно подложить приватный и публичный ключ в `./hbbr_data`

```docker-compose
services:
  hbbr:
    image: docker.io/rustdesk/rustdesk-server-pro:1.6.2
    container_name: hbbr
    command: hbbr
    volumes:
      - ./hbbr_data:/root
    environment:
      # https://github.com/rustdesk/rustdesk-server/tree/master?tab=readme-ov-file#env-variables
      - "RUST_LOG=DEBUG"
    network_mode: host
    cap_add:
      - NET_ADMIN
    restart: unless-stopped

networks:
  rustdesk-net:
    driver: bridge
    ipam:
      config:
        - subnet: 172.21.0.0/16
```

Подробная настройка описана в [Документации](https://rustdesk.com/docs/en/self-host/rustdesk-server-pro/relay/), там же описание настройки GeoLocation для выбора ближайшего hbbr к клиенту-цупу (если не включён vpn)

## ENV variables

| variable | binary | description |
| --- | --- | --- |
| ALWAYS_USE_RELAY | hbbs | if set to **"Y"** disallows direct peer connection |
| DB_URL | hbbs | path for database file |
| DOWNGRADE_START_CHECK | hbbr | delay (in seconds) before downgrade check |
| DOWNGRADE_THRESHOLD | hbbr | threshold of downgrade check (bit/ms) |
| KEY | hbbs/hbbr | if set force the use of a specific key, if set to **"_"** force the use of any key |
| LIMIT_SPEED | hbbr | speed limit (in Mb/s) |
| PORT | hbbs/hbbr | listening port (21116 for hbbs - 21117 for hbbr) |
| RELAY | hbbs | IP address/DNS name of the machines running hbbr (separated by comma) |
| RUST_LOG | all | set debug level (error\|warn\|info\|debug\|trace) |
| SINGLE_BANDWIDTH | hbbr | max bandwidth for a single connection (in Mb/s) |
| TOTAL_BANDWIDTH | hbbr | max total bandwidth (in Mb/s) |