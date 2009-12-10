NGINX_VERSION=0.7.64
wget http://sysoev.ru/nginx/nginx-$NGINX_VERSION.tar.gz
tar xzvf nginx-$NGINX_VERSION.tar.gz
cd nginx-$NGINX_VERSION
./configure --prefix=/usr/local/nginx-$NGINX_VERSION
make
sudo make install
sudo ln -s /usr/local/nginx-0.7.64/ /usr/local/nginx

sudo mkdir /var/log/nginx
