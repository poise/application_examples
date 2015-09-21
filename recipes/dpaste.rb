#
# Copyright 2015, Noah Kantrowitz
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

# For compiling Mysqldb even though we don't use it.
include_recipe 'build-essential'

application node['dpaste']['path'] do
  git 'https://github.com/bartTC/dpaste.git'
  python '2'
  virtualenv
  package node.value_for_platform(%w{debian ubuntu} => {default: 'libmysqlclient-dev'}, %w{redhat centos} => {'~> 7.0' => 'mariadb-devel', '~> 6.0' => 'mysql-devel'})
  pip_requirements
  file ::File.join(path, 'dpaste', 'settings', 'deploy.py') do
    content "from dpaste.settings.base import *\nfrom dpaste.settings.local_settings import *\n"
  end
  django do
    allowed_hosts ['localhost', node['fqdn']]
    settings_module 'dpaste.settings.deploy'
    database 'sqlite:///dpaste.db'
    syncdb true
    migrate true
  end
  gunicorn
end
