# This script is used to restore default permissions and owners for splunk use cases.
# Splunks docker images are build using ansible and change permissions for mouted files.

echo ">>> Reset Permissions for $(pwd)"
echo ">>> Reset owner and group to mo:mo"
chown -R mo:mo .

echo ">>> Reset file and directory permissions"
find . -type f -print0|xargs -0 chmod 664
find . -type d -print0|xargs -0 chmod 775

echo ">>> Make run.sh executeable again"
chmod +x ./run.sh
