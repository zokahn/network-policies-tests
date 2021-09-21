#!/bin/bash

oc delete project simpson
oc delete project bouvier

echo "Waiting for delete action to finish"

sleep 30

