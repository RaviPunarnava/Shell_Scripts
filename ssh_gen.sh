cat test.sh
#!/bin/bash
set -x
XYZ=$(expect -c "
spawn ssh-keygen -b 2048 -t rsa -f /tmp/sshkey -q
expect \"Enter passphrase (empty for no passphrase):\"
send \"\r\"
expect \"Enter same passphrase again:\"
send \"\r\"
")