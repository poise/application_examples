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

require 'net/http'
require 'securerandom'

require 'serverspec'
set :backend, :exec

describe 'todo_rails' do
  describe port(8000) do
    it { is_expected.to be_listening }
  end

  let(:http) { Net::HTTP.new('localhost', 8000) }

  describe '/' do
    subject { http.get('/') }
    its(:code) { is_expected.to eq '200' }
    its(:body) { is_expected.to include '<title>Getting Things Done with Engine Yard</title>' }
    its(:body) { is_expected.to include 'Rock on!' }
  end

  describe '/lists/1/tasks' do
    subject { http.get('/lists/1/tasks') }
    its(:code) { is_expected.to eq '200' }
    its(:body) { is_expected.to include 'Rock on!' }
  end

  describe 'with a task' do
    # Random task each time for test isolation-ish.
    let(:task_text) { SecureRandom.hex(10) }
    subject do
      index = http.get('/')
      # Look for something like name="csrf-token" content="6UPNa+SBVhZ/fgJK78OJUjb7LwftMCtrRxZ8D79vInI9SDkuSnfsd0f3BFYuBgtE6YPmMMO3y7Ruja0+YIk7XQ=="
      unless index.body =~ /name="csrf-token" content="([^"]+)"/
        raise 'CSRF token not found'
      end
      csrf_token = $1
      cookie = index.response['set-cookie'].split('; ')[0]
      http.post('/lists/1/tasks', "authenticity_token=#{csrf_token}&task[name]=#{task_text}&task[list_id]=1&task[done]=false", {'Cookie' => cookie})
      http.get('/')
    end
    its(:code) { is_expected.to eq '200' }
    its(:body) { is_expected.to include task_text }
  end
end
