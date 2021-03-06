#!/bin/bash
set -ex

DEFAULT_COREDNS_IMAGE=coredns/coredns:1.6.2

[ -z ${COREDNS_IMAGE} ] && COREDNS_IMAGE=${DEFAULT_COREDNS_IMAGE}

cat codedns.yaml | sed "s@__COREDNS_IMAGE__@${COREDNS_IMAGE}@" | kubectl apply -f -

cat autoscaler.yaml | kubectl apply -f -

echo kubectl scale deployment kube-dns-autoscaler --replicas 0 -n kube-system
echo kubectl scale deployment kube-dns --replicas 0 -n kube-system
