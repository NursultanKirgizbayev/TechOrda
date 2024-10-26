# nginx-ip

Защита ценных ресурсов и сервисов в Интернете должна осуществляться поэтапно. NGINX является одним из этих этапов.

Директива `deny` блокирует доступ к конкретному блоку, а директива `allow` может использоваться для
разрешения подмножества заблокированного доступа. Вы можете использовать IP-адреса, IPv4 или IPv6, и ключевое слово `all`.

Как правило, при защите ресурса можно запретить доступ для всех к определенному `location` блоку и разрешить доступ только с определенных IP адресов.

### Полезные ссылки

- [Restricting Access by IP Address ](https://docs.nginx.com/nginx/admin-guide/security-controls/controlling-access-proxied-tcp/)
- [How to block/allow IP-addresses in Nginx](https://support.hypernode.com/en/hypernode/nginx/how-to-block-allow-ip-addresses-in-nginx)

### Задание

1. Настройте `server` блок, который слушает 8080 порт.
2. Установите `server_name` равным значению `example.com`.
3. Добавьте `location /secret_word`, который возвращает строку `jusan-nginx-ip` со статусом `203`. Разрешите доступ к блоку из `192.0.0.1/20` кроме `192.0.0.1` и запретите все остальные.
4. Отправьте получившийся результат.

---

### Ответ


server {
    listen 8080;
    server_name example.com;

    location / {
        root /var/www/html;
        index index.html;
    }
    
    location /api {
        proxy_pass http://localhost:9090;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /images {
        alias /var/www/images/;
	auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/.htpasswd_design;
    }

    location /gifs {
        alias /var/www/gifs/;
	auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/.htpasswd_marketing;
    }

    location /secret_word {
        return 203 'jusan-nginx-locations';
        add_header Content-Type text/plain;
	return 203 'jusan-nginx-ip';

        # Настройка доступа
        allow 192.0.0.1/20;
        deny 192.0.0.1;
        deny all;
    }
}