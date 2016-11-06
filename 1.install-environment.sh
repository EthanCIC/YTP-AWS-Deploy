# 安裝 Ruby on Rails 環境
# 更新系統
apt-get update
apt-get upgrade -y

# 安裝 Rails 相依套件
apt-get install -y build-essential git-core bison openssl libreadline6-dev curl zlib1g \
zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3  autoconf libc6-dev libmysqlclient-dev \
libpq-dev libpcre3-dev curl libcurl4-nss-dev libxml2-dev libxslt-dev imagemagick nodejs libffi-dev

# 安裝 Ruby
apt-get install -y --force-yes software-properties-common
apt-add-repository ppa:brightbox/ruby-ng -y
apt-get update
apt-get install -y ruby2.3 ruby2.3-dev

# install latest nodejs
curl --silent --location https://deb.nodesource.com/setup_6.x | bash -
apt-get install -y nodejs

# install Bundler, Rails
gem install bundler --no-ri --no-rdoc
gem install rails --no-ri --no-rdoc

# 安裝 Nginx + Passenger
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7

apt-get install -y --force-yes apt-transport-https ca-certificates

# Add APT repository
sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'

apt-get update

# Install Passenger + Nginx
apt-get install -y nginx-extras passenger

service nginx restart

# install latest git
apt-add-repository ppa:git-core/ppa -y
apt-get update
apt-get install -y git

# install latest nodejs
curl --silent --location https://deb.nodesource.com/setup_6.x | bash -
apt-get install -y nodejs

sed -i "s/user www-data;/env PATH;\nuser www-data;/g" /etc/nginx/nginx.conf
sed -i "s/# include \/etc\/nginx\/passenger.conf;/include \/etc\/nginx\/passenger.conf;/g" /etc/nginx/nginx.conf

service nginx restart