#!/bin/bash

SERVER_NAME=${SERVER_NAME:-"phpmyadmin.test.org"}

SECRET=$(date|md5sum| awk '{print $1}')

cat >/var/www/config.inc.php<<EOF
<?php
\$cfg['blowfish_secret'] = '$SECRET';
\$i = 0;
\$i++;
\$cfg['Servers'][\$i]['auth_type'] = 'cookie';
\$cfg['Servers'][\$i]['host'] = 'database';
\$cfg['Servers'][\$i]['connect_type'] = 'tcp';
\$cfg['Servers'][\$i]['compress'] = false;
\$cfg['Servers'][\$i]['AllowNoPassword'] = false;
\$cfg['UploadDir'] = '';
\$cfg['SaveDir'] = '';
?>
EOF

cat >/etc/nginx/conf.d/phpmyadmin.conf<<EOF
server {
        server_name $SERVER_NAME;
        root /var/www;
 
        client_max_body_size 5m;
        client_body_timeout 60;
 
        location ~ [^/]\.php(/|\$) {
                fastcgi_split_path_info ^(.+?\.php)(/.*)$;
                if (!-f \$document_root\$fastcgi_script_name) {
                        return 404;
                }
                fastcgi_pass 127.0.0.1:9000;
                fastcgi_index index.php;
                include fastcgi_params;
        }
}
EOF

supervisord -c /etc/supervisord.conf
