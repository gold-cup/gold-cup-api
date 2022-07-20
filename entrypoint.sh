#!/bin/sh

echo "Wait for db to be ready before running migrations"

count=0
return_code=1
while [ $return_code -ne 0 ]
do
    count=`expr $count + 1`
    echo "Running test $count"
    /usr/bin/mysql -h $DATABASE_HOST -P $DATABASE_PORT -u $DATABASE_USERNAME --password=$DATABASE_PASSWORD -e '\q'
    return_code=$?
    if [[ $return_code -eq 0 ]]; then
        echo "Database is ready to run migrations"
        break
    else
        echo "Could not connect to database - (return code $return_code)"
    fi
    if [[ $count -ge 10 ]]; then
        echo "exceeded execution....exiting"
        break
        exit 1
    fi
    echo "Waiting before running test again"
    sleep 10
done

echo "Running rake commands to initialize db and run migrations"
rails db:create db:migrate

echo "Starting application"
rails server -b 0.0.0.0 -p $PORT