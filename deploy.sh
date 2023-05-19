kind create cluster --config kind-config.yaml

docker pull quay.io/cilium/cilium:v1.13.2
docker pull nicolaka/netshoot
docker pull nginx
kind load docker-image quay.io/cilium/cilium:v1.13.2
kind load docker-image nicolaka/netshoot
kind load docker-image nginx

helm install cilium cilium/cilium --version 1.13.2 \
   --namespace kube-system \
   --set image.pullPolicy=IfNotPresent \
   --set k8sServiceHost=kind-control-plane \
   --set k8sServicePort=6443 \
   --set kubeProxyReplacement=strict \
   --set ipam.mode=kubernetes \
   --set ipv6.enabled=true \
   --set hubble.relay.enabled=true \
   --set hubble.ui.enabled=true
 
