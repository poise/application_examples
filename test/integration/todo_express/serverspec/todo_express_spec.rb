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

require 'net/http'
require 'securerandom'

require 'serverspec'
set :backend, :exec

describe 'todo_express' do
  describe port(3000) do
    it { is_expected.to be_listening }
  end

  let(:http) { Net::HTTP.new('localhost', 3000) }

  describe '/' do
    subject { http.get('/') }
    its(:code) { is_expected.to eq '200' }
    its(:body) { is_expected.to include '<title>Home | Express.js Todo App</title>' }
  end

  describe '/tasks' do
    subject { http.get('/tasks') }
    its(:code) { is_expected.to eq '200' }
    its(:body) { is_expected.to include '<title>Todo List | Express.js Todo App</title>' }
  end

  describe 'with a task' do
    # Random task each time for test isolation-ish.
    let(:task_text) { SecureRandom.hex(10) }
    subject do
      tasks_page = http.get('/tasks')
      # Look for something like value="FTy2twC7-VV1iU3l656C2do87u0CRU1oHpK0" name="_csrf"
      unless tasks_page.body =~ /value="([^"]+)" name="_csrf"/
        raise 'CSRF token not found'
      end
      csrf_token = $1
      cookie = tasks_page.response['set-cookie'].split('; ')[0]
      http.post('/tasks', "_csrf=#{csrf_token}&name=#{task_text}", {'Cookie' => cookie})
      http.get('/tasks')
    end
    its(:code) { is_expected.to eq '200' }
    its(:body) { is_expected.to include task_text }
  end
end
