# build rails project nginx config
cat > /etc/nginx/sites-enabled/project << EOF
server {
  listen 80;
  server_name {{ EC2 PUBLIC-IP }}; # 還沒 domain 的話，先填 IP 位置

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
git clone {{ YOUR-PROJECT-GITHUB-LINK }} project
cd project

bundle install --deployment --without test development

RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake assets:precompile

# restart nginx service
service nginx restart

