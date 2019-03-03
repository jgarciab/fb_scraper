#!/usr/bin/env bash

cd tensorflow-for-poets-2

python -m scripts.retrain \
        --bottleneck_dir=tf_files/bottlenecks \
        --model_dir=tf_files/models/ \
        --summaries_dir=tf_files/training_summaries/"mobilenet_0.75_224_party" \
        --output_graph=tf_files/retrained_graph_mobilenet_0.75_224_party.pb \
        --output_labels=tf_files/retrained_labels_mobilenet_0.75_224_party.txt \
        --architecture="mobilenet_0.75_224" \
        --how_many_training_steps=2000 \
        --image_dir=../../images_resized/224/party

python -m scripts.retrain \
        --bottleneck_dir=tf_files/bottlenecks \
        --model_dir=tf_files/models/ \
        --summaries_dir=tf_files/training_summaries/"inception_v3_party" \
        --output_graph=tf_files/retrained_graph_inception_v3_party.pb \
        --output_labels=tf_files/retrained_labels_inception_v3_party.txt \
        --architecture="inception_v3" \
        --how_many_training_steps=2000 \
        --image_dir=../../images_resized/299/party

python -m scripts.retrain \
        --bottleneck_dir=tf_files/bottlenecks \
        --model_dir=tf_files/models/ \
        --summaries_dir=tf_files/training_summaries/"mobilenet_0.75_224_wing" \
        --output_graph=tf_files/retrained_graph_mobilenet_0.75_224_wing.pb \
        --output_labels=tf_files/retrained_labels_mobilenet_0.75_224_wing.txt \
        --architecture="mobilenet_0.75_224" \
        --how_many_training_steps=2000 \
        --image_dir=../../images_resized/224/wing

python -m scripts.retrain \
        --bottleneck_dir=tf_files/bottlenecks \
        --model_dir=tf_files/models/ \
        --summaries_dir=tf_files/training_summaries/"inception_v3_wing" \
        --output_graph=tf_files/retrained_graph_inception_v3_wing.pb \
        --output_labels=tf_files/retrained_labels_inception_v3_wing.txt \
        --architecture="inception_v3" \
        --how_many_training_steps=2000 \
        --image_dir=../../images_resized/299/wing

#
# Tensorflowjs
# Convert TF model and copy its output to the "test-faces" webapp
#
tensorflowjs_converter \
        --input_format=tf_frozen_model \
        --output_node_names=final_result \
        tf_files/retrained_graph_mobilenet_0.75_224_party.pb \
        tf_web/retrained_graph_mobilenet_0.75_224_party

rm ../../test-faces/model/*

cp \
        tf_web/retrained_graph_mobilenet_0.75_224_party/* \
        ../../test-faces/model

cd ..