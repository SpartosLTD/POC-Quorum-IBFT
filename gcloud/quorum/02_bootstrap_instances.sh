#!/usr/bin/env bash

GROUP=$1
COUNT=$2
NETWORK_FOLDER=${3:-$GROUP}

declare -A zones

zones[0]="europe-west3-b"
zones[1]="europe-west3-a"
zones[2]="europe-west3-b"
zones[3]="europe-west3-c"
zones[4]="europe-west2-b"
zones[5]="europe-west2-c"
zones[6]="europe-west1-b"
zones[7]="europe-west1-c"

#Run setup script on instance
for (( i=1; i<=$COUNT; i++ ))
do
    let ZONE_INDEX=$i%7
    echo "Zone index $ZONE_INDEX"
    ZONE=${zones[$ZONE_INDEX]}
    INSTANCE_NAME=${GROUP}-${i}
    echo "Bootstrapping Quorum node $INSTANCE_NAME"

    #1. Remove old files if exist
    gcloud compute ssh $INSTANCE_NAME --zone=$ZONE --command="sudo rm -rf ~/quorum"

    #2. Copy initial files
    gcloud compute scp --recurse --zone=$ZONE $NETWORK_FOLDER $INSTANCE_NAME:~/quorum

    #3. Provision
    #gcloud compute ssh $INSTANCE_NAME --zone=$ZONE --command="cd ~/quorum; sudo ./bootstrap.sh"

done