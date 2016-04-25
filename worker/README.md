#inside of a fresh box, do the following:
curl -fsSL https://get.docker.com/ | sh
docker pull bamos/openface
docker run -p 9000:9000 -p 8000:8000 -t -i bamos/openface /bin/bash

#inside docker container, do the following: (works on $40/month digital ocean box)
cd /root/src/openface
./data/download-lfw-subset.sh
./run-tests.sh
./demos/compare.py images/examples/{lennon*,clapton*}
./demos/classifier.py infer models/openface/celeb-classifier.nn4.small2.v1.pkl ./images/examples/carell.jpg
