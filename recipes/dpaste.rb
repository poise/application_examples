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

# For compiling Mysqldb even though we don't use it, because it is in the
# requirements.txt no matter what.
include_recipe 'build-essential'
package node.value_for_platform(
  %w{debian ubuntu} => {default: 'libmysqlclient-dev'},
  %w{redhat centos} => {'~> 7.0' => 'mariadb-devel', '~> 6.0' => 'mysql-devel'},
)

# Application resource for Dpaste.
application node['dpaste']['path'] do
  # Clone the source code from GitHub.
  git 'https://github.com/bartTC/dpaste.git'
  # Install Python 2.x for our application.
  python '2'
  # Create a virtualenv for our application.
  virtualenv
  # Run `pip install -r requirements.txt` to install dependencies.
  pip_requirements
  # Write out a settings file to include the app-level base settings and then
  # our local settings. In a more normal application flow, we would import
  # local_settings directly in the main settings.py file.
  file ::File.join(path, 'dpaste', 'settings', 'deploy.py') do
    content "from dpaste.settings.base import *\nfrom dpaste.settings.local_settings import *\n"
  end
  # Run Django deployment steps for this application.
  django do
    # Set the ALLOWED_HOSTS.
    allowed_hosts ['localhost', node['fqdn']]
    # Set the DJANGO_SETTINGS_MODULE.
    settings_module 'dpaste.settings.deploy'
    # Configure the Django ORM to use a local SQLite database.
    database 'sqlite:///dpaste.db'
    # Run migrate because this is a one-server "toy" application.
    migrate true
  end
  # Create a system service to run Gunicorn on port 80.
  gunicorn
end
