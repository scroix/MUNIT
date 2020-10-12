if [[ "$(docker images -q munit:1.2 2> /dev/null)" == "" ]]; then
  docker build --tag munit:1.2 .
else
  docker run -v $(pwd):/app --runtime=nvidia -it munit:1.2 /bin/bash
fi