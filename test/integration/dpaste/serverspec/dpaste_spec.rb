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

require 'serverspec'
set :backend, :exec

describe 'DPaste' do
  describe port(80) do
    it { is_expected.to be_listening }
  end

  let(:http) { Net::HTTP.new('localhost', 80) }

  describe 'index' do
    subject { http.get('/') }
    its(:code) { is_expected.to eq '200' }
    its(:body) { is_expected.to include '<title>dpaste.de: New snippet</title>' }
  end

  describe 'api' do
    subject do
      url = http.post('/api/', 'content=Hello+world!&format=url').body.strip
      paste_id = url.split(/\//).last
      http.get("/#{paste_id}/raw")
    end
    its(:code) { is_expected.to eq '200' }
    its(:body) { is_expected.to eq "Hello world!\n" }
  end
end
