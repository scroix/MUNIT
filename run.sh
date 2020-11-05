if [[ "$(docker images -q munit-cuda11 2> /dev/null)" == "" ]]; then
  docker build --tag munit-cuda11 .
else
  docker run -v $(pwd):/app --runtime=nvidia -it munit-cuda11 /bin/bash
fi