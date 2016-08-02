#
# Copyright 2015-2016, Noah Kantrowitz
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
#

# A reduced MongoDB recipe to install just enough for our tests.

# Because older MongoDB segfaults if the locale isn't available.
execute 'locale-gen en_US.UTF-8' if platform_family?('debian')
# MongoDB data folder.
directory '/data/db' do
  recursive true
end
# Download and unpack MongoDB binary builds.
package 'tar'
poise_archive 'https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.0.6.tgz' do
  destination '/root/mongodb-linux-x86_64-3.0.6'
end
# Make a system service.
poise_service 'mongodb' do
  provider :dummy
  command '/root/mongodb-linux-x86_64-3.0.6/bin/mongod'
end
