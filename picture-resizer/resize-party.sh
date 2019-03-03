#!/usr/bin/env bash

declare -a vox=("278350739554651" "243857799756496")
declare -a pp=("325981981309863" "206111790275597" "1530834263889012" "280157568676224" "1472997079606848" "1201579429856806")
declare -a cs=("ValenciaNaranja" "1059245690762811")
declare -a psoe=("607370216390187" "192181397587499")
declare -a podemos=("despilfarro" "1595424737336462")
declare -a iu=("920605494695845" "10389356063")

echo "Create required folders"
mkdir -p ../images_resized/{224,299}/party
mkdir -p ../images_resized/{224,299}/party/{vox,pp,cs,psoe,podemos,iu}

echo "Create dataset categories (political party)"
for i in "${vox[@]}"
do
  cp -r ../images_processed/$i/*.jpg ../images_resized/224/party/vox
  cp -r ../images_processed/$i/*.jpg ../images_resized/299/party/vox
done

for i in "${pp[@]}"
do
  cp -r ../images_processed/$i/*.jpg ../images_resized/224/party/pp
  cp -r ../images_processed/$i/*.jpg ../images_resized/299/party/pp
done

for i in "${cs[@]}"
do
  cp -r ../images_processed/$i/*.jpg ../images_resized/224/party/cs
  cp -r ../images_processed/$i/*.jpg ../images_resized/299/party/cs
done

for i in "${psoe[@]}"
do
  cp -r ../images_processed/$i/*.jpg ../images_resized/224/party/psoe
  cp -r ../images_processed/$i/*.jpg ../images_resized/299/party/psoe
done

for i in "${podemos[@]}"
do
  cp -r ../images_processed/$i/*.jpg ../images_resized/224/party/podemos
  cp -r ../images_processed/$i/*.jpg ../images_resized/299/party/podemos
done

for i in "${iu[@]}"
do
  cp -r ../images_processed/$i/*.jpg ../images_resized/224/party/iu
  cp -r ../images_processed/$i/*.jpg ../images_resized/299/party/iu
done

echo "Resize images"
# prepare the images for tensorflow (the model requires 224x244 inputs)
magick mogrify -resize 224x224 ../images_resized/224/party/vox/*.jpg
magick mogrify -resize 224x224 ../images_resized/224/party/pp/*.jpg
magick mogrify -resize 224x224 ../images_resized/224/party/cs/*.jpg
magick mogrify -resize 224x224 ../images_resized/224/party/psoe/*.jpg
magick mogrify -resize 224x224 ../images_resized/224/party/podemos/*.jpg
magick mogrify -resize 224x224 ../images_resized/224/party/iu/*.jpg

magick mogrify -resize 299x299 ../images_resized/299/party/vox/*.jpg
magick mogrify -resize 299x299 ../images_resized/299/party/pp/*.jpg
magick mogrify -resize 299x299 ../images_resized/299/party/cs/*.jpg
magick mogrify -resize 299x299 ../images_resized/299/party/psoe/*.jpg
magick mogrify -resize 299x299 ../images_resized/299/party/podemos/*.jpg
magick mogrify -resize 299x299 ../images_resized/299/party/iu/*.jpg