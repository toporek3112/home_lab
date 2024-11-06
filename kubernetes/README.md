# K3s on raspbarry pi 4

## Installation

### swap

1. Turn off swap temporary.
sudo swapoff -a
1. To turn of swap permanently `sudo vim /etc/dphys-swapfile`
3. Set `CONF_SWAPSIZE=0`
4. Save the changes.

### cgroups

1. Open the cmdline.txt file `sudo vim /boot/cmdline.txt`
2. Add below into THE END of the current line
`console=serial0,115200 console=tty1 root=PARTUUID=8995323e-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory`
3. Save the file and reboot `sudo reboot`

### k3s

1. Run `curl -sfL https://get.k3s.io | sh -`
2. Kubeconfig can be found under: `cat /etc/rancher/k3s/k3s.yaml`

### Crossplane 

1. Add Helm repo
```
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
```

2. Install Crossplane
```
helm install crossplane --namespace crossplane-system --create-namespace crossplane-stable/crossplane 
```

3. Install Crossplane CLI
```
curl -sL https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh | sh
sudo mv crossplane /usr/local/bin/
```

4. Install Crossplane Github provider
```
kubectl crossplane install provider crossplane/provider-github:v0.18.0
```
