#!/bin/bash

echo "==> Cleanup yum cache"
yum -y clean all

echo "==> Cleaning up temporary network addresses"
# radio off & remove all interface configration
nmcli radio all off
/bin/systemctl stop NetworkManager.service
for ifcfg in `ls /etc/sysconfig/network-scripts/ifcfg-* |grep -v ifcfg-lo` ; do
 rm -f $ifcfg
done
rm -rf /var/lib/NetworkManager/*

echo "==> Setup /etc/rc.d/rc.local for CentOS7"
cat <<EOF | cat >> /etc/rc.d/rc.local
#BOXCUTTER-BEGIN
LANG=C

# delete all connection
for con in \`nmcli -t -f uuid con\`; do
  if [ "\$con" != "" ]; then
    nmcli con del \$con
  fi
done

# add gateway interface connection.
gwdev=\`nmcli dev | grep ethernet | egrep -v 'unmanaged' | head -n 1 | awk '{print \$1}'\`
if [ "\$gwdev" != "" ]; then
  nmcli c add type eth ifname \$gwdev con-name \$gwdev
fi
chmod -x /etc/rc.d/rc.local
sed -i -e "/^#BOXCUTTER-BEGIN/,/^#BOXCUTTER-END/ d" /etc/rc.d/rc.local
#BOXCUTTER-END
EOF
chmod +x /etc/rc.d/rc.local

echo "==> Remove generated SSH host keys"
rm -f /etc/ssh/ssh_host_*

echo "==> Removing temporary files used to build box"
rm -rf /tmp/*

echo "==> Cleanup log files"
find /var/log -type f | while read f; do echo -ne '' > $f; done;

echo "==> Remove bash history"
rm -f /root/.bash_history

echo '==> Zeroing out empty area to save space in the final image'
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
sync