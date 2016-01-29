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

source 'https://rubygems.org/'

def dev_gem(name, path: File.join('..', name), github: nil)
  path = File.expand_path(File.join('..', path), __FILE__)
  if File.exist?(path)
    gem name, path: path
  elsif github
    gem name, github: github
  else
    gem name
  end
end

dev_gem 'halite'
dev_gem 'poise'
dev_gem 'poise-application', path: '../application'
dev_gem 'poise-application-git', path: '../application_git'
dev_gem 'poise-application-python', path: '../application_python'
dev_gem 'poise-application-javascript', path: '../application_javascript'
dev_gem 'poise-application-ruby', path: '../application_ruby'
dev_gem 'poise-boiler'
dev_gem 'poise-languages'
dev_gem 'poise-python'
dev_gem 'poise-javascript'
dev_gem 'poise-ruby'
dev_gem 'poise-service'

gem 'berkshelf', '~> 4.0'
