#!/bin/sh

brew install fuse4x ntfs-3g

sudo /bin/cp -rfX $(brew --prefix)/Cellar/fuse4x-kext/*/Library/Extensions/fuse4x.kext /Library/Extensions
sudo /bin/chmod +s /Library/Extensions/fuse4x.kext/Support/load_fuse4x

cat > mount_ntfs <<EOF
#!/bin/bash

VOLUME_NAME="\${@:\$#}"
VOLUME_NAME=\${VOLUME_NAME#/Volumes/}
USER_ID=501
GROUP_ID=20
TIMEOUT=20

if [ \`/usr/bin/stat -f "%u" /dev/console\` -eq 0 ]; then
  USERNAME=\`/usr/bin/defaults read /library/preferences/com.apple.loginwindow | /usr/bin/grep autoLoginUser | /usr/bin/awk '{ print \$3 }' | /usr/bin/sed 's/;//'\`
  if [ "\$USERNAME" = "" ]; then
    until [ \`stat -f "%u" /dev/console\` -ne 0 ] || [ $TIMEOUT -eq 0 ]; do
      sleep 1
      let TIMEOUT--
    done
    if [ \$TIMEOUT -ne 0 ]; then
      USER_ID=\`/usr/bin/stat -f "%u" /dev/console\`
      GROUP_ID=\`/usr/bin/stat -f "%g" /dev/console\`
    fi
  else
    USER_ID=\`/usr/bin/id -u \$USERNAME\`
    GROUP_ID=\`/usr/bin/id -g \$USERNAME\`
  fi
else
  USER_ID=\`/usr/bin/stat -f "%u" /dev/console\`
  GROUP_ID=\`/usr/bin/stat -f "%g" /dev/console\`
fi

/usr/local/bin/ntfs-3g \\
  -o volname="\${VOLUME_NAME}" \\
  -o local \\
  -o negative_vncache \\
  -o auto_xattr \\
  -o auto_cache \\
  -o noatime \\
  -o windows_names \\
  -o user_xattr \\
  -o inherit \\
  -o uid=\$USER_ID \\
  -o gid=\$GROUP_ID \\
  -o allow_other \\
  "\$@" &> /var/log/ntfsmnt.log

exit \$?;
EOF

sudo /bin/chown root:wheel mount_ntfs
sudo /bin/chmod 755 mount_ntfs
sudo /bin/mv /sbin/mount_ntfs /sbin/mount_ntfs-ro
sudo /bin/mv mount_ntfs /sbin/
