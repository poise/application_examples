# Application_Examples Cookbook

[![Build Status](https://img.shields.io/travis/poise/application_examples.svg)](https://travis-ci.org/poise/application_examples)
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

Example applications deployed using the [`application` cookbooks](https://github.com/poise/application).

## Quick Start

Clone or download this repository and then:

```bash
$ bundle install
# ... install gem dependencies
$ berks install
# ... install Chef cookbook dependencies
$ kitchen converge 14
# ... launch Ubuntu 14.04 VMs for each example application
```

## Applications

### Dpaste

[Dpaste](https://github.com/poise/application_examples/blob/master/recipes/dpaste.rb)
is a pastebin application written in Django that powers
[pastebin.de](http://pastebin.de/). Here we are deploying it on top of SQLite as
the database and Gunicorn as the web server.

```bash
$ kitchen converge dpaste-ubuntu-1404
$ kitchen login dpaste-ubuntu-1404
$ curl http://localhost/
```

### Todo_Rails

[Todo_Rails](https://github.com/poise/application_examples/blob/master/recipes/todo_rails.rb)
is a todo list application written in Rails. We are deploying on SQlite and
Unicorn.

```bash
$ kitchen converge todo-rails-ubuntu-1404
$ kitchen login todo-rails-ubuntu-1404
$ curl http://localhost:8000/
```

### Todo_Express

[Todo_Express](https://github.com/poise/application_examples/blob/master/recipes/todo_express.rb)
is a todo list application written in Express and backed by Node.js and MongoDB.

```bash
$ kitchen converge todo-express-ubuntu-1404
$ kitchen login todo-express-ubuntu-1404
$ curl http://localhost:3000/
```

## Sponsors

The Poise test server infrastructure is sponsored by [Rackspace](https://rackspace.com/).

## License

Copyright 2015-2017, Noah Kantrowitz

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
