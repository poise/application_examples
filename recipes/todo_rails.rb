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

# Databases we won't use (╯°□°）╯︵ ┻━┻
include_recipe 'build-essential'
package node.value_for_platform(
  %w{debian ubuntu} => {default: %w{libmysqlclient-dev libpq-dev libsqlite3-dev}},
  %w{redhat centos} => {'~> 7.0' => %w{mariadb-devel postgresql-libs postgresql-devel sqlite-devel},
                        '~> 6.0' => %w{mysql-devel postgresql-libs postgresql-devel sqlite-devel}},
)

# Application resource for Todo_Express.
application node['todo_rails']['path'] do
  # Clone the source code from GitHub.
  git 'https://github.com/engineyard/todo.git'
  # Install Ruby.
  ruby_runtime 'any' do
    version ''
  end
  # Install node for execjs and link it globally.
  nodejs = javascript 'nodejs'
  link '/usr/bin/node' do
    to nodejs.javascript_binary
  end
  # Run `bundle install` to install dependencies.
  bundle_install
  # Handle Rails deployment.
  rails do
    database 'sqlite3:///db.sqlite3'
    secret_token 'd78fe08df56c9'
    migrate true
  end
  # Create a system service to run Unicorn on port 8000.
  unicorn do
    port 8000
  end
end
