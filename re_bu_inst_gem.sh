#!/bin/sh

version=$1
spec_name=$(ls *.gemspec)
gem_name=${spec_name%%.*}
gem_pack="${gem_name}-${version}.gem"

rm ${gem_pack}
gem uninstall ${gem_name}
gem build ${spec_name}
gem install -N ./${gem_pack}
