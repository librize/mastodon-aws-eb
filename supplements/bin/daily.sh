#!/bin/ash

echo "Starting"

case $ENV_TYPE in
"web" )
  echo "Running web"
  ;;
"streaming" )
  echo "Running streaming"
  bundle exec rails mastodon:daily
  ;;
* )
  echo "Error ENV_TYPE=$ENV_TYPE"
esac

echo "Finished"
