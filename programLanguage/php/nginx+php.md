# nginx+php安装可道云

``` shell
apt update && apt install -y nginx php-fpm php-gd php-curl php-mbstring php-intl php-intl php-imagick php-bz2 php-dev php-pear php-memcached memcached
```


配置nginx
``` shell
vim /etc/nginx/sites-available/default
```

conf : 

`index index.php index.html index.htm index.nginx-debian.html;`

```
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
        #
        #       # With php-fpm (or other unix sockets):
                fastcgi_pass unix:/run/php/php7.4-fpm.sock;
        #       # With php-cgi (or other tcp sockets):
        #       fastcgi_pass 127.0.0.1:9000;
        }
```
