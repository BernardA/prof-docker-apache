#!/bin/sh
set -e

if grep -q ^DATABASE_HOST= .env; then
    # cat .env
    echo "Waiting for db to be ready..."
    ATTEMPTS_LEFT_TO_REACH_DATABASE=30
    until [ $ATTEMPTS_LEFT_TO_REACH_DATABASE -eq 0 ] || DATABASE_ERROR=$(bin/console dbal:run-sql "SELECT 1" 2>&1); do
        if [ $? -eq 30 ]; then
            # If the Doctrine command exits with 255, an unrecoverable error occurred
            ATTEMPTS_LEFT_TO_REACH_DATABASE=0
            break
        fi
        sleep 1
        ATTEMPTS_LEFT_TO_REACH_DATABASE=$((ATTEMPTS_LEFT_TO_REACH_DATABASE - 1))
        echo "Still waiting for db to be ready... Or maybe the db is not reachable. $ATTEMPTS_LEFT_TO_REACH_DATABASE attempts left"
    done

    if [ $ATTEMPTS_LEFT_TO_REACH_DATABASE -eq 0 ]; then
        echo "The database is not up or not reachable:"
        echo "$DATABASE_ERROR"
        exit 1
    else
        echo "The db is now ready and reachable"
    fi

    if [ "$( find ./migrations -iname '*.php' -print -quit )" ]; then
        bin/console doctrine:migrations:migrate --no-interaction
    fi
fi
# /usr/sbin/apache2ctl -D FOREGROUND
exec docker-php-entrypoint "$@"
