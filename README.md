# fb_scraper

This is a quick & dirty proof of concept to determine whether it is possible to classify voters using their Facebook profile pictures.

Several steps are involved:
1. Download profile pictures from different groups using selenium (see [fb_group_scraping_update.ipynb jupyter notebook](./fb_group_scraping_update.ipynb)). Images are left under "[images](./images)".
2. Filter those pictures that doesn't contain a face on it. For this purpose we use opencv4nodejs (see [face-detector](./face-detector)). Filtered images are left under "[images_processed](./images_processed)". This step requires Node.JS.
3. Normalize/resize the images to 224x224 that is the size expected by MobileNet (see [picture-resizer](./picture-resizer)). Resized images are left under  "[images_resized](./images_resized)". This step requires ImageMagick.
4. Retrain two TensorFlow models (MobileNet + Inception_v3) (see [tensorflow](./tensorflow)) and converts the mobilenet one to be able to use it in a browser. This step requires tensorflow and tensorflowjs.

## Run

Execute `run.sh` to run the steps avobe.

You can try `test-faces` (node and ngrok required):
```
npx http-server ./test-faces
ngrok http 8080
```

## Pictures

The folder "images" contains raw profile pictures scraped from political groups.

* right-wing spanish parties:
  - "ValenciaNaranja" ("Yo quiero que Ciudadanos (Cs) gobierne ESPAÑA")
  - "1059245690762811" ("españa ciudadana")
  - "421520031260556" ("con la marea azul del partido popular")
  - "325981981309863" ("orgullo de ser del partido popular")
  - "278350739554651" ("arriba vox !!!! España está contigo")
  - "243857799756496" ("vox el futuro de España")
  - "206111790275597" ("grupo de apoyo al partido popular")
  - "1530834263889012" ("yo voto partido popular")
  - "280157568676224" ("partido popular pp")
  - "1472997079606848" ("apoyo al partido popular")
  - "1201579429856806" ("partido popular, seguira gobernando")

* left-wing spanish parties:
  - "despilfarro" ("podemos al gobierno - pueblo al poder")
  - "1595424737336462" ("podemos digital España")
  - "607370216390187" ("psoe + psoe a vencer")
  - "192181397587499" ("el psoe es mas que un partido. Es el Progreso de España")
  - "920605494695845" ("Izquierda unida l@s roj@s")
  - "10389356063" ("Izquierda Unida")

Don't be evil.
