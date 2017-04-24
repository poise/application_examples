#
# Copyright 2015-2017, Noah Kantrowitz
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

name 'application_examples'
version '1.0.0'

maintainer 'Noah Kantrowitz'
maintainer_email 'noah@coderanger.net'
license 'Apache-2.0'
description 'Examples for using the Application cookbooks.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://github.com/poise/application_examples' if defined?(source_url)
issues_url 'https://github.com/poise/application_examples/issues' if defined?(issues_url)
supports 'ubuntu'
supports 'centos'

depends 'application', '~> 5.0'
depends 'application_git', '~> 1.0'
depends 'application_javascript', '~> 1.0'
depends 'application_python', '~> 4.0'
depends 'application_ruby', '~> 4.0'
depends 'build-essential'
depends 'poise', '~> 2.0'
depends 'poise-archive', '~> 1.3'
