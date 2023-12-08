#!/bin/bash

python3 sdfwapi.py groups-yelb.json create
python3 sdfwapi.py services-yelb.json create
python3 sdfwapi.py dfw-policy_yelb-app.json create
python3 sdfwapi.py container-cluster.json create
echo 'All done!'
