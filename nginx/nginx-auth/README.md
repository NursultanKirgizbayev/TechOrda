# nginx-auth

### Задание

1. Настройте `server` блок, который слушает 8080 порт.
2. Установите `server_name` значению `example.com`.
3. Добавьте `location` блок для пути `/`, который обслуживает файл [index.html](https://stepik.org/media/attachments/lesson/686238/index.html)
4. Добавьте `location` блок для пути `/images`, который обслуживает файлы из архива [cats.zip](https://stepik.org/media/attachments/lesson/686238/cats.zip). Установите авторизованный вход для учетки: `design:SteveJobs1955`, т.е. логин `design`, пароль `SteveJobs1955`.
5. Добавьте `location` блок для пути `/gifs`, который обслуживает файлы из архива [gifs.zip](https://stepik.org/media/attachments/lesson/686238/gifs.zip). Установите авторизованный вход для учетки: `marketing:marketingP@ssword`.
6. Учетка `design` не должна иметь доступ на другие пути, тоже самое касается других учеток.

---

sudo apt-get install apache2-utils 

sudo htpasswd -c /etc/nginx/.htpasswd_design design
sudo htpasswd -c /etc/nginx/.htpasswd_marketing marketing


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
        return 201 'jusan-nginx-locations';
        add_header Content-Type text/plain;
    }
}
