#!/bin/bash
echo "Your local dev Enviromnent is about to be setup"
cd ..
export LOCATION=$(pwd)
sed -i "s|YOUR_PATH|$LOCATION|g" devspaces/doc-converter-collection.yml
echo "Creating collection and pushing repo files"
cndevspaces collections create -f devspaces/doc-converter-collection.yml
echo "starting bind, this could take some time as we need to upload +500Mb"
cndevspaces bind -C doc-converter-col -c doc-converter -v
echo "Then we save th state of our container so next time it saves time on the initial sync"
cndevspaces save
echo "Finally we enter the container to execute the build and run for the product"
cndevspaces exec -C doc-converter-col -r doc-conv-cont
