#!/bin/bash
#
# Jekyll Docker
# https://github.com/envygeeks/jekyll-docker
#
# Enable to simulate production features, e.g. comments
#
#     --env JEKYLL_ENV=production
#
export JEKYLL_VERSION=3.8
docker run --rm \
  -p 4000:4000 \
  --env "JIMI_USERNAME=${JIMI_USERNAME}" \
  --env "JIMI_PASSWORD=${JIMI_PASSWORD}" \
  --name jekyll \
  --volume "${PWD}:/srv/jekyll" \
  --volume "${PWD}/vendor/bundle:/usr/local/bundle" \
  -it "jekyll/jekyll:${JEKYLL_VERSION}" \
  jekyll serve --trace $@
