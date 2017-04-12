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

# A reduced MongoDB recipe to install just enough for our tests.
include_recipe 'application_examples::_mongodb'

# Application resource for Todo_Express.
application node['todo_express']['path'] do
  # Clone the source code from GitHub.
  git 'https://github.com/azat-co/todo-express.git'
  # Install the latest Node.js.
  javascript 'nodejs'
  # Run `npm install` to install dependencies.
  npm_install
  # Create a system service to run `npm start` to get the application listening
  # on port 3000.
  npm_start
end
