#!/usr/bin/env bash

echo "Filter images that contain a face"
cd face-detector
npm install
node index.js
cd ..

echo "Resize images"
cd picture-resizer
sh resize-party.sh
sh resize-wing.sh
cd ..

echo "Retrain tensorflow models"
cd tensorflow
sh train.sh
cd ..