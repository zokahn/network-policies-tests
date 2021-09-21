#!/bin/bash

members=( "marge.simpson" "homer.simpson" "selma.bouvier" "patty.bouvier" )

for i in
cat << EOF >> ../deploy/simpson-and-bouvier/$i/container-helper.yaml
  - name: xs4all.nl
    host: www.xs4all.nl
    port: 80
  - name: router
    host: 192.178.2.254
    port: 80
EOF
