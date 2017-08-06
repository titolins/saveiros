#v2
* install wordpress:
```
cd /var/www
sudo curl -O https://wordpress.org/latest.tar.gz
sudo tar zxf latest.tar.gz
sudo rm latest.tar.gz
sudo mv wordpress html
sudo chown -R www-data:www-data html
```

* install caddy:
```
curl https://getcaddy.com | bash
```
* copy caddy.service to `/etc/systemd/system`
* copy Caddyfile to `/etc/caddy`

* install docker:
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker ${USER}
```
* set wordpress configs as per the below:
    * db_name: wordpress
    * user: root
    * password: ''
    * db_host: mariadb

* get skpy dockerfiles and setup docker:
```
mkdir skpy-dockerfiles
cd skpy-dockerfiles
git clone https://github.com/skpy/Dockerfiles .
cd php
sudo docker build -t skpy:php .
sudo docker run -d -v /var/lib/mysql:/var/lib/mysql --name mariadb mariadb:latest
sudo docker run -d -p 9000:9000 -v /var/www/html:/var/www/html --link mariadb --name php --restart=always skpy:php
```

* make caddy directories:
```
sudo mkdir -p /var/log/caddy /etc/ssl/caddy
```

* set required permissions:
```
sudo setcap 'cap_net_bind_service=+ep' /usr/local/bin/caddy
sudo groupadd -g 33 www-data
sudo useradd \
    -g www-data --no-user-group \
    --home-dir /var/www --no-create-home \
    --shell /usr/sbin/nologin \
    --system --uid 33 www-data

sudo mkdir /etc/caddy
sudo chown -R root:www-data /etc/caddy
sudo mkdir /etc/ssl/caddy
sudo chown -R www-data:root /etc/ssl/caddy
sudo chmod 0770 /etc/ssl/caddy
sudo mkdir /var/log/caddy
sudo chown root:www-data /var/log/caddy
sudo chmod 0775 /var/log/caddy
```

* create the database
```
docker exec -i -t vagrant_mariadb_1 /bin/bash
mysql -u root
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```
# references
* https://skippy.net/caddy-docker-php-wordpress/
* https://hub.docker.com/_/mariadb/
