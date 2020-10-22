# This script is used to restore default permissions and owners for splunk use cases.
# Splunks docker images are build using ansible and change permissions for mouted files.

echo ">>> Reset Permissions for $(pwd)"
chown -R mo:mo .
find . -type f -print0|xargs -0 chmod 664
find . -type d -print0|xargs -0 chmod 775

chmod +x ./run.sh
