#!/bin/sh


SERVER=${LOCAL_DELIVERY_IP:-192.168.33.66}
ENT='cd'
ORG='local'
USER=$LOCAL_DELIVERY_CLUSTER_USER

delivery setup --server $SERVER --ent $ENT --org $ORG --user $USER

sleep 2

delivery token

delivery api post orgs --data='{"name": "Deps-Demo"}'
sleep 2
delivery api post orgs/$ORG/projects --data='{"name": "cookbook_a"}'
delivery api post orgs/$ORG/projects --data='{"name": "cookbook_b"}'
delivery api post orgs/$ORG/projects --data='{"name": "cookbook_c"}'

sleep 2

cd cookbook_a
rm -rf .git
git init
git remote add delivery ssh://$USER@$ENT@$SERVER:8989/$ENT/$ORG/cookbook_a
git push delivery master
cd ../cookbook_b
rm -rf .git
git init
git remote add delivery ssh://$USER@$ENT@$SERVER:8989/$ENT/$ORG/cookbook_b
git push delivery master
cd ../cookbook_c
rm -rf .git
git init
git remote add delivery ssh://$USER@$ENT@$SERVER:8989/$ENT/$ORG/cookbook_c
git push delivery master
cd ..

sleep 2

delivery api post orgs/$ORG/projects/cookbook_a/pipelines --data='{"name": "master", "base": "master"}'
delivery api post orgs/$ORG/projects/cookbook_b/pipelines --data='{"name": "master", "base": "master"}'
delivery api post orgs/$ORG/projects/cookbook_c/pipelines --data='{"name": "master", "base": "master"}'
