#!/bin/ash

echo "Starting"

case $ENV_TYPE in
"web" )
  echo "Running web"
  bundle exec rails db:migrate
  mkdir -p tmp/pids
  bundle exec sidekiq -c 5 -q default -q mailers -q pull -q push -d -l log/sidekiq.log -P tmp/pids/sidekiq.pid
  bundle exec rails server -p 4000 -b 0.0.0.0
  bundle exec sidekiqctl stop tmp/pids/sidekiq.pid
  ;;
"streaming" )
  echo "Running streaming"
  npm run start
  ;;
* )
  echo "Error ENV_TYPE=$ENV_TYPE"
esac
echo "Finished"
