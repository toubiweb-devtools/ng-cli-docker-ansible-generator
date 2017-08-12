#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ANSIBLE_PLAYBOOK=$BASE_DIR/ng-cli.cookbook.yml
ANSIBLE_VERBOSE=-vvvv
ANSIBLE_TAGS=all
ANSIBLE_EXTRA_VARS=
ANSIBLE_BECOME_CONFIG="--ask-become-pas"

#!/bin/bash
echo ""
echo "Welcome in ng-cli+docker/ansible project generator"
echo ""
echo "USAGE:"
echo "./ng-cli.sh [--config=my-app.yml] [--skip-become]"
echo ""
echo "Configuration files are located in $BASE_DIR/config/"
echo ""

for i in "$@"
do
case $i in
    --config=*)
    config="${i#*=}"
    CONFIG_FILEPATH="$BASE_DIR/config/$config"
    shift # past argument=value
    ;;
    --skip-become=*)
    ANSIBLE_BECOME_CONFIG=
    shift # past argument=value
    ;;
    *)
		# unknown option
		echo Unknown option "${i#*=}"
    ;;
esac
done

if [ -z $CONFIG_FILEPATH ]
then

  prompt="Please select a configuration file:"
  options=( $(find $BASE_DIR/config -maxdepth 1 -name "*.yml" -print0 | xargs -0) )

  PS3="$prompt "
  select CONFIG_FILEPATH in "${options[@]}" "Quit" ; do
      if (( REPLY == 1 + ${#options[@]} )) ; then
          exit

      elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
          break

      else
          echo "Invalid option. Try another one."
      fi
  done
fi

ANSIBLE_EXTRA_VARS="$ANSIBLE_EXTRA_VARS CONFIG_FILEPATH=$CONFIG_FILEPATH"

ansible-playbook $ANSIBLE_VERBOSE -i "localhost," -c local $ANSIBLE_PLAYBOOK --verbose --tags "$ANSIBLE_TAGS" $ANSIBLE_BECOME_CONFIG --extra-vars "$ANSIBLE_EXTRA_VARS"
