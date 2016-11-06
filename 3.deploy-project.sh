sed -i "s/listen 80 default_server;/listen 80;/g" /etc/nginx/sites-available/default
sed -i "s/listen \[::\]:80 default_server;/listen \[::\]:80;/g" /etc/nginx/sites-available/default

# build rails project nginx config
cat > /etc/nginx/sites-enabled/project << EOF
server {
  listen 80 default_server;
  listen [::]:80 default_server;

  server_name _;

  root /home/ubuntu/project/public;

  passenger_enabled on;

  passenger_min_instances 1;

  location ~ ^/assets/ {
    expires 1y;
    add_header Cache-Control public;
    add_header ETag "";
    break;
   }
}
EOF

# deploy project
cd /home/ubuntu
git clone https://github.com/ethan0526/ytp-project.git project
cd project

bundle install --deployment --without test development

RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake assets:precompile

# restart nginx service
service nginx restart

