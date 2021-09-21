#!/bin/bash

DEPLOY_DIR='/home/bart/network-policies-tests/deploy/simpson-and-bouvier'

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
./run-tmux.sh apps.openshift-pilot.sandbox.nfv.local
