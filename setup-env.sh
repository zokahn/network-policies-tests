#!/usr/bin/env bash
cd deploy/simpson-and-bouvier

oc delete project simpson
sleep 5
oc delete project bouvier
sleep 30

oc new-project simpson
oc apply -k homer.simpson
oc apply -k marge.simpson
oc new-project bouvier
oc apply -k patty.bouvier
oc apply -k selma.bouvier
