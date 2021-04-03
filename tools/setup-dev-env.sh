#!/usr/bin/env bash

# get current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# use script dir
cd $DIR

# ensure first cli argument is lowercase
ACTION=$(echo $1 | tr "[:upper:]" "[:lower:]")


clear
case $ACTION in
    "undeploy")
        echo "--- Undeploying development environment ---"
        docker stop webgoat
        docker rm webgoat
        docker rmi webgoat/webgoat-8.0
        docker system prune -f
        vagrant destroy -f
        ;;
    "stop")
        echo "--- Stopping development environment ---"
        docker stop webgoat
        vagrant suspend
        ;;

    "deploy")
        # setup Vagrant
        vagrant up
        vagrant status
        echo "--- vagrant is running. Run 'vagrant ssh' for access ---"

        # setup WebGoat
        if [[ $(docker ps -a --filter "name=webgoat" --format '{{.Names}}') == "webgoat" ]]; then
            docker start webgoat
        else
            docker run -p 8080:8080 -d --name webgoat -t webgoat/webgoat-8.0
        fi
        ;;
    *)
      clear
      printf "\nERROR: don't know what to do!\n\nusage:\n  ./setup-dev-env.sh [deploy|stop|undeploy]\n\n"
      ;;
esac

cd -
