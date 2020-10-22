# This script is used to restore default permissions and owners for splunk use cases.
# Splunks docker images are build using ansible and change permissions for mouted files.

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi


echo ">>> Reset Permissions for $(pwd)"
echo ">>> Reset owner and group to mo:mo"
# User has to be hardcoded here because this script needs sudo to be able to change permissions.
chown -R mo:mo .

echo ">>> Reset file and directory permissions"
find . -type f -print0|xargs -0 chmod 664
find . -type d -print0|xargs -0 chmod 775

echo ">>> Make run.sh executeable again"
chmod +x ./run.sh
