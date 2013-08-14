## starcraft2

A small StarCraft 2 API wrapper. For full documentation, visit https://github.com/Blizzard/api-sc2-docs.

## Installation

Add to your `Gemfile`:

```ruby
gem "starcraft2"
```

Then `bundle install`.

## Usage

```ruby
Starcraft2::Client.new(:host => 'us.battle.net', :locale => 'en_US')
```

A full list of hosts and locales can be found in the API documentation above.

## Build Status
[![Build Status](https://travis-ci.org/zquestz/starcraft2.png)](https://travis-ci.org/zquestz/starcraft2)

## License

Copyright (c) 2013 by Josh Ellithorpe, James Fickel, and Jan Hein Hoogstad

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
