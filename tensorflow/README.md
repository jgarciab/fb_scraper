# tensorflow classifier

## Train the model

Tensorflow utils cloned from https://github.com/googlecodelabs/tensorflow-for-poets-2

### Classify by party

```sh
python -m scripts.retrain \
        --bottleneck_dir=tf_files/bottlenecks \
        --model_dir=tf_files/models/ \
        --summaries_dir=tf_files/training_summaries/"mobilenet_0.75_224_party" \
        --output_graph=tf_files/retrained_graph_mobilenet_0.75_224_party.pb \
        --output_labels=tf_files/retrained_labels_mobilenet_0.75_224_party.txt \
        --architecture="mobilenet_0.75_224" \
        --how_many_training_steps=2000 \
        --image_dir=../../images_resized/224/party
```

```sh
python -m scripts.retrain \
        --bottleneck_dir=tf_files/bottlenecks \
        --model_dir=tf_files/models/ \
        --summaries_dir=tf_files/training_summaries/"inception_v3_party" \
        --output_graph=tf_files/retrained_graph_inception_v3_party.pb \
        --output_labels=tf_files/retrained_labels_inception_v3_party.txt \
        --architecture="inception_v3" \
        --how_many_training_steps=2000 \
        --image_dir=../../images_resized/299/party
```

### Classify by wing (left vs right)

```sh
python -m scripts.retrain \
        --bottleneck_dir=tf_files/bottlenecks \
        --model_dir=tf_files/models/ \
        --summaries_dir=tf_files/training_summaries/"mobilenet_0.75_224_wing" \
        --output_graph=tf_files/retrained_graph_mobilenet_0.75_224_wing.pb \
        --output_labels=tf_files/retrained_labels_mobilenet_0.75_224_wing.txt \
        --architecture="mobilenet_0.75_224" \
        --how_many_training_steps=2000 \
        --image_dir=../../images_resized/224/wing
```

```sh
python -m scripts.retrain \
        --bottleneck_dir=tf_files/bottlenecks \
        --model_dir=tf_files/models/ \
        --summaries_dir=tf_files/training_summaries/"inception_v3_wing" \
        --output_graph=tf_files/retrained_graph_inception_v3_wing.pb \
        --output_labels=tf_files/retrained_labels_inception_v3_wing.txt \
        --architecture="inception_v3" \
        --how_many_training_steps=2000 \
        --image_dir=../../images_resized/299/wing
```

It will take some time. You'll see the accuracy at the end:

```
INFO:tensorflow:2019-02-23 23:28:25.932728: Step 4999: Train accuracy = 77.0%
INFO:tensorflow:2019-02-23 23:28:25.932864: Step 4999: Cross entropy = 0.486686
INFO:tensorflow:2019-02-23 23:28:26.013980: Step 4999: Validation accuracy = 59.0% (N=100)
INFO:tensorflow:Final test accuracy = 55.1% (N=294)
```

You can use other models instead of "inception_v3" (e.g. "mobilenet").

## Validate

### inception_v3

Use 299x299 images for inception_v3

```sh
python -m scripts.label_image \
        --graph=tf_files/retrained_graph_inception_v3_wing.pb \
        --image=../../control1.jpg  --input_layer=Mul --input_width 299 --input_height 299 --labels=tf_files/retrained_labels_inception_v3_wing.txt
```

```sh
python -m scripts.label_image \
        --graph=tf_files/retrained_graph_inception_v3_party.pb \
        --image=../../control1.jpg  --input_layer=Mul --input_width 299 --input_height 299 --labels=tf_files/retrained_labels_inception_v3_party.txt
```

### mobilenet

Use 224x224 images

```sh
python -m scripts.label_image \
        --graph=tf_files/retrained_graph_mobilenet_0.75_224_party.pb  \
        --image=../../control1.jpg \
        --labels=tf_files/retrained_labels_mobilenet_0.75_224_party.txt
```

```sh
python -m scripts.label_image \
        --graph=tf_files/retrained_graph_mobilenet_0.75_224_wing.pb  \
        --image=../../control1.jpg \
        --labels=tf_files/retrained_labels_mobilenet_0.75_224_wing.txt
```