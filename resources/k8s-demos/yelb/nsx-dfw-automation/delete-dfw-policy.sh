#!/bin/bash

echo "Cleaning up DFW, services and groups ..."
python3 sdfwapi.py dfw-policy_yelb-app.json delete
python3 sdfwapi.py services-yelb.json delete
python3 sdfwapi.py groups-yelb.json delete
echo 'All done!'
