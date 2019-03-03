#!/usr/bin/env bash

declare -a right=("1530834263889012" "280157568676224" "1472997079606848" "1201579429856806" "ValenciaNaranja" "1059245690762811" "421520031260556" "325981981309863" "278350739554651" "243857799756496" "206111790275597")
declare -a left=("920605494695845" "10389356063" "despilfarro" "1595424737336462" "607370216390187" "192181397587499")

echo "Create required folders"
mkdir -p ../images_resized/{224,299}/wing
mkdir -p ../images_resized/{224,299}/wing/{left,right}

echo "Create dataset categories (left + right)"
for i in "${right[@]}"
do
  cp -r ../images_processed/$i/*.jpg ../images_resized/224/wing/right
  cp -r ../images_processed/$i/*.jpg ../images_resized/299/wing/right
done

for i in "${left[@]}"
do
   cp -r ../images_processed/$i/*.jpg ../images_resized/224/wing/left
   cp -r ../images_processed/$i/*.jpg ../images_resized/299/wing/left
done

echo "Resize images"
# prepare the images for tensorflow (the model requires 224x244 inputs)
magick mogrify -resize 224x224 ../images_resized/224/wing/right/*.jpg
magick mogrify -resize 224x224 ../images_resized/224/wing/left/*.jpg
magick mogrify -resize 299x299 ../images_resized/299/wing/right/*.jpg
magick mogrify -resize 299x299 ../images_resized/299/wing/left/*.jpg