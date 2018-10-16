#!/bin/bash

SERVER=bitbucket.mycompany.net
USERNAME=username
PASSWORD=password
PROJECTS=`curl -u $USERNAME:$PASSWORD https://$SERVER/rest/api/1.0/projects/\?limit\=1000 | jq -r '.values[].key'`

echo $PROJECTS

for i in $PROJECTS; do
echo $i
curl -s -u $USERNAME:$PASSWORD https://$SERVER/rest/api/1.0/projects/$i/repos/\?limit\=1000 \
  | jq -r '.values[].links.clone[] | select(.name=="ssh") | .href' \
| xargs -I {} echo "git clone '{}'" >> clone_repos.sh
done;
