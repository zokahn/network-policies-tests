#!/bin/bash

cat << EOF >> ../deploy/simpson-and-bouvier/homer.simpson/container-helper.yaml
  - name: xs4all.nl
    host: www.xs4all.nl
    port: 80
  - name: router
    host: 192.178.2.254
    port: 443
EOF
