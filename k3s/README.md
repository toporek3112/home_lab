# K3s on raspbarry pi 4

## Installation

# 1. Turn off swap temporary.
sudo swapoff -a

# 2. To turn of swap permanently we need to update the `CONF_SWAPSIZE` in `dphys-swapfile` file to `0`
sudo nano /etc/dphys-swapfile

# 3. set
  CONF_SWAPSIZE=0

# 4. select control + X and save the changes.

# cgroups

# 1. Open the cmdline.txt file
sudo nano /boot/cmdline.txt

# 2. Add below into THE END of the current line
console=serial0,115200 console=tty1 root=PARTUUID=8995323e-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory

# 3. Save the file and reboot
sudo reboot

cgroup_memory=1 cgroup_enable=memory