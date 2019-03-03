//
// Inspired by https://github.com/justadudewhohacks/opencv4nodejs/blob/master/examples/faceDetect/faceDetection.js
//

const fs = require('fs');
const path = require('path');
const cv = require('opencv4nodejs');

// draw utils
const drawRect = (image, rect, color, opts = { thickness: 2 }) =>
  image.drawRectangle(
    rect,
    color,
    opts.thickness,
    cv.LINE_8
  );

const drawBlueRect = (image, rect, opts = { thickness: 2 }) =>
  drawRect(image, rect, new cv.Vec(255, 0, 0), opts);

// file utils
const walkSync = (dir, filelist = []) => {
  fs.readdirSync(dir).forEach(file => {
    filelist = fs.statSync(path.join(dir, file)).isDirectory()
      ? walkSync(path.join(dir, file), filelist)
      : filelist.concat(path.join(dir, file));

  });

  return filelist;
}

const mkdirSync = (dirPath) => {
  try {
    fs.mkdirSync(dirPath)
  } catch (err) {
    if (err.code !== 'EEXIST') throw err
  }
}

let countPictures = 0;
let countFaces = 0;

const images = walkSync('../images');

images
  .filter(image => image.endsWith('.jpg'))
  .forEach(image => {
    const folder = image.split('/')[2]; // XXX very hacky and OS specific
    mkdirSync('../images_processed' + '/' + folder);
    const name = image.split('/')[3];

    const targetFile = '../images_processed/' + folder + '/' + name;
    if (!fs.existsSync(targetFile)) {
      const picture = cv.imread(image);
      const classifier = new cv.CascadeClassifier(cv.HAAR_FRONTALFACE_ALT2); // XXX try cv.HAAR_PROFILEFACE, etc

      // detect faces
      const result = classifier.detectMultiScale(picture.bgrToGray());

      countPictures++;
      if (countPictures % 500 === 0) {
        console.log('.');
      }

      if (result.objects.length === 1) {
        countFaces++;

        // Draw a blue rect, useful for debugging purposes
        // const numDetectionsTh = 10;
        // objects.forEach((rect, i) => {
        //    const thickness = numDetections[i] < numDetectionsTh ? 1 : 2;
        //    drawBlueRect(picture, rect, { thickness });
        // });

        cv.imwrite(targetFile, picture);
      }
    }
});

console.log("Pictures %d, Faces %d", countPictures, countFaces);
