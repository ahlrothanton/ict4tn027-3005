#!/usr/bin/env bash
#
# simple wrapper script around Vagrant

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
        vagrant destroy -f
        ;;
    "stop")
        echo "--- Stopping development environment ---"
        vagrant suspend
        ;;

    "deploy")
        echo "--- Starting development environment ---"
        # ensure vbquest is installed
        vagrant plugin install vagrant-vbguest

        # setup Vagrant
        vagrant up
        vagrant status
        ;;
    *)
      clear
      printf "\nERROR: don't know what to do!\n\nusage:\n  ./setup-dev-env.sh [deploy|stop|undeploy]\n\n"
      ;;
esac

cd -
