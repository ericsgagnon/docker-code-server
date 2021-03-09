#!/bin/bash

# docker build --pull -t ericsgagnon/code-server:dev -f Dockerfile .
# docker push ericsgagnon/code-server:dev
# docker run -d -i -t -p 8080:8080 --name code --gpus all ericsgagnon/code-server:dev
# cd $(git rev-parse --show-toplevel)/final
# git show-ref --tags -d | sed -e 's,.* refs/tags/,,' -e 's/\^{}//'
# GIT_HEAD=$(git show-ref --head | head -n 1 | sed -E "s/(^\\w+).*/\1/g")
# git rev-parse HEAD
# git tag -f $(date +%Y%m%d) && git tag -f dev
# cd $(git rev-parse --show-toplevel)/final && docker build --build-arg=GIT_TAG=$(git describe --tags) --pull -t ericsgagnon/ide-base:$(git describe --tags)-final -f Dockerfile .
# docker tag ericsgagnon/ide-base:
# docker run -i -t --rm --name ide --gpus all ericsgagnon/ide-base:$(git describe --tags)-final /bin/bash
# docker push ericsgagnon/ide-base:$(git describe HEAD --tags)-final && docker tag ericsgagnon/ide-base:$(git describe HEAD --tags)-final ericsgagnon/ide-base:$(git describe HEAD --tags) && docker push ericsgagnon/ide-base:$(git describe HEAD --tags)
# docker run -d -i -t --name ide --gpus all ericsgagnon/ide-base:$(git describe --tags)-final
# docker run --rm --name ide --gpus all ericsgagnon/ide-base:dev-final nvidia-smi
#!/bin/bash  

VERSION=$1

build_tag="${VERSION}"
echo "Build Tag: ${build_tag}"


docker build --pull -t ericsgagnon/code-server:${build_tag}  -f Dockerfile . 
build_exit_code=$?

if [[ $build_exit_code -ne 0 ]] ; then
   echo "build failed"
   exit 1
fi

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



# docker build --pull -t ericsgagnon/ide-base:dev-languages -f Dockerfile .
# cd $(git rev-parse --show-toplevel)/languages && docker build --build-arg=GIT_TAG=$(git describe --tags) --pull -t ericsgagnon/ide-base:$(git describe --tags)-languages -f Dockerfile .
# docker run -i -t --rm --name ide --gpus all ericsgagnon/ide-base:$(git describe --tags)-languages /bin/bash
# docker push ericsgagnon/ide-base:$(git describe --tags)-languages
# docker run -d -i -t --name ide --gpus all ericsgagnon/ide-base:$(git describe --tags)-languages
# docker run -d -i -t --name ide --gpus all ericsgagnon/ide-base:dev-languages
# docker run --rm --name ide --gpus all ericsgagnon/ide-base:dev-languages nvidia-smi
