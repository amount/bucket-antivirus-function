# Upside Travel, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

AMZ_LINUX_VERSION:=latest
current_dir := $(shell pwd)
container_dir := /opt/app

all: archive

clean:
	rm -rf compile/lambda.zip

archive: clean
	echo $(current_dir)
	echo $(shell pwd)
	docker run --rm -i \
		-v $(shell pwd):/opt/app \
		amazonlinux:$(AMZ_LINUX_VERSION) \
	/bin/bash -c "cd /opt/app && ls -al"

		# "cd /opt/app && #&& ./build_lambda.sh"
