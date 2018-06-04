#!/bin/sh

# Check that a .ctfd_secret_key file or SECRET_KEY envvar is set
if [ ! -f .ctfd_secret_key ] && [ -z "$SECRET_KEY" ]; then
    if [ $WORKERS -gt 1 ]; then
        echo "[ ERROR ] You are configured to use more than 1 worker."
        echo "[ ERROR ] To do this, you must define the SECRET_KEY environment variable or create a .ctfd_secret_key file."
        echo "[ ERROR ] Exiting..."
        exit 1
    fi
fi

# Check that the database is available
if [ -n "$DATABASE_URL" ]
    then
    database=`echo $DATABASE_URL | awk -F[@//] '{print $4}'`
    echo "Waiting for $database to be ready"
    while ! mysqladmin ping -h $database --silent; do
        # Show some progress
        echo -n '.';
        sleep 1;
    done
    echo "$database is ready"
    # Give it another second.
    sleep 1;
fi

if [ -z "$WORKERS" ]; then
    WORKERS=1
fi

if [ -n "$SERVER_ROOT" ]; then
  /opt/CTFd/ctfd.ini.sh
  ln -s /etc/uwsgi/apps-available/ctfd.ini /etc/uwsgi/apps-enabled/ctfd.ini
fi

# Start CTFd
echo "Starting CTFd"
uwsgi --socket 0.0.0.0:8000 --protocol=http -w "CTFd:create_app()" --logto "${LOG_FOLDER:-/opt/CTFd/CTFd/logs}/uwsgi.log"
