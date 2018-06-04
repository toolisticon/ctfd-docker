#!/bin/sh
mkdir -p /etc/uwsgi/apps-available
mkdir -p /etc/uwsgi/apps-enabled/
cat <<EOF > /etc/uwsgi/apps-available/ctfd.ini
# UWSGI Configuration File
# Install uwsgi (sudo apt-get install uwsgi), copy this file to
# /etc/uwsgi/apps-available and then link it in /etc/uwsgi/apps-enabled
# Only two lines below (commented) need to be changed for your config.
# Then, you can use something like the following in your nginx config:
#
#        # SERVER_ROOT is not / (e.g. /ctf)
#        location = /ctf { rewrite ^ /ctf/; }
#        location /ctf {
#            include uwsgi_params;
#            uwsgi_pass unix:/run/uwsgi/app/ctfd/socket;
#        }
#
#        # SERVER_ROOT is /
#        location / {
#            include uwsgi_params;
#            wsgi_pass unix:/run/uwsgi/app/ctfd/socket;
#        }
[uwsgi]
# Where you've put CTFD
chdir = /var/www/ctfd/
mount = $SCRIPT_ROOT=wsgi.py

# You shouldn't need to change anything past here
plugin = python
module = wsgi

master = true
processes = 1
threads = 1

vacuum = true

manage-script-name = true
wsgi-file = wsgi.py
callable = app

die-on-term = true

# If you're not on debian/ubuntu, replace with uid/gid of web user
uid = www-data
gid = www-data
EOF
