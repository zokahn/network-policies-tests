#!/bin/bash

DEPLOY_DIR='/root/git/network-policies-tests/deploy/simpson-and-bouvier'
GUES_DOMAIN=$(oc whoami --show-console | awk -F  "." ' {print $2"."$3"."$4"."$5}')

if [ "$1" == "" ] ; then
  echo "Please run $0 <domain>"
  echo "domain is where the ingress dns wildcard points to"
  echo "Your domain is guessed as $GUES_DOMAIN"
  exit 1;
fi



echo "Press enter to continue"
read -n 1 k <&1
echo "building the simpson demo"

cd $DEPLOY_DIR

oc new-project simpson
oc apply -k homer.simpson
oc apply -k marge.simpson
oc new-project bouvier
oc apply -k patty.bouvier
oc apply -k selma.bouvier

echo "stuff built, ready to tmux results"
read -n 1 k <&1
cd ../..
./run-tmux.sh apps.open
