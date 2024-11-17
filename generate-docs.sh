#!/usr/bin/env bash
set -e
if hash readme-generator 2>/dev/null; then
    echo "readme-generator installed"
else
    echo 'readme-generator not found in $PATH. Please install it first.
You can run `npm install -g https://github.com/bitnami-labs/readme-generator-for-helm` for that'
    exit 1
fi
for v in $(ls charts/*/values.yaml);
do
    dir=$(dirname $v)
    echo $dir
    # readme-generator -r $dir/README.md -v $dir/values.yaml -s $dir/values.schema.json
    readme-generator -r $dir/README.md -v $dir/values.yaml
done
