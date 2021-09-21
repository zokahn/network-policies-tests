#!/bin/bash

echo "Press enter to continue"
read -n 1 k <&1

oc get pods -o wide -n simpson
oc get pods -o wide -n bouvier

echo "Showing the pods, ready for deny all rule on the simpson namespace"
read -n 1 k <&1

cat << EOF


kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: default-deny
spec:
  podSelector: {}


EOF

oc create -n simpson  -f - <<EOF
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: default-deny
spec:
  podSelector: {}
EOF

echo "Deny rule set for the simpsons, ready to allow access to ingress controller"
read -n 1 k <&1

oc project simpson

cat << EOF


apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-from-openshift-ingress
spec:
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          network.openshift.io/policy-group: ingress
  podSelector: {}
  policyTypes:
  - Ingress


EOF

cat << EOF| oc create -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-from-openshift-ingress
spec:
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          network.openshift.io/policy-group: ingress
  podSelector: {}
  policyTypes:
  - Ingress
EOF

echo "Allowed the ingress, ready to allow access inside the Simpsons"
read -n 1 k <&1

cat << EOF| oc create -f -
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: allow-same-namespace
spec:
  podSelector:
  ingress:
  - from:
    - podSelector: {}
EOF

cat <<EOF


kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: allow-same-namespace
spec:
  podSelector:
  ingress:
  - from:
    - podSelector: {}


EOF


echo "Allowed traffic inside the simpsons, ready to allow bouvier traffic /n First set a label to bouvier"
read -n 1 k <&1

oc label namespace/bouvier name-tst=bouvier

echo "Allowed traffic inside the simpsons, ready to allow bouvier traffic, set the policy"
read -n 1 k <&1

oc create -n simpson -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-from-bouviers-to-marge
spec:
  podSelector:
    matchLabels:
      app: marge
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          name-tst: bouvier
EOF

cat << EOF


apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-from-bouviers-to-marge
spec:
  podSelector:
    matchLabels:
      app: marge
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          name-tst: bouvier


EOF
