#!/bin/bash

VERSION=$1

build_tag="${VERSION}"
echo "Build Tag: ${build_tag}"


docker build --pull --no-cache=true -t ericsgagnon/code-server:${build_tag}  -f Dockerfile . 
build_exit_code=$?

if [[ $build_exit_code -ne 0 ]] ; then
   echo "build failed"
   exit 1
fi

echo "docker push ericsgagnon/code-server:${build_tag}"
docker push ericsgagnon/code-server:${build_tag}
push_exit_code=$?
if [[ ${push_exit_code} -ne 0 ]] ; then
  echo "push failed"
  exit 1
fi

echo "test the image by:"
echo "docker run -d -i -t --gpus all -p 8080:8080 --name code ericsgagnon/code-server:${build_tag}"
echo "sleep 10 && docker logs code "
echo "docker exec -i -t code /bin/bash"
echo "# cleanup"
echo "docker rm -fv code"
