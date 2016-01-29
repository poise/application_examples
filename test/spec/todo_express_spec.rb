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

require 'spec_helper'

describe 'application_examples::todo_express' do
  let(:chefspec_options) { {platform: 'ubuntu', version: '14.04'} }
  let(:halite_gemspec) do
    Gem::Specification.stubs.map do |spec|
      Halite::Gem.new(spec)
    end.select do |cook|
      # Make sure this is a cookbook.
      cook.is_halite_cookbook?
    end.map do |cook|
      cook.spec
    end
  end
  recipe metadata[:description]

  it { is_expected.to deploy_application('/srv/todo_express') }
  it { is_expected.to install_application_npm_install('/srv/todo_express').with(npm_binary: %r{/opt/nodejs-[^/]+/bin/npm}) }
end
