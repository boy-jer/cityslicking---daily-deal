# Preface

* Commands should be run from the main application directory



# Getting Started

## Technologies required to get started

* [Ruby 1.9.2](http://www.ruby-lang.org/)
* [RubyGems](https://rubygems.org/)
* [Bundler](http://gembundler.com/)
* [Rack](http://rack.rubyforge.org/)
* [SQLite3](http://www.sqlite.org/) (for development environment only)

## Starting the app

Make sure you have the gems installed:

    bundle install

Then start the app on Rack:

    rackup

See it running at: [http://localhost:9292/](http://localhost:9292/)

## Stopping the app

    ^C

## Restarting the app on Passenger

    rake app:restart



# Prerequisites

* Web serving is provided by [Rack](http://rack.rubyforge.org/)
* Routing is provided by [Sinatra](http://www.sinatrarb.com/)
* Object relational mapping is provided by [DataMapper](http://datamapper.org/)
* Email sending is provided by [Pony](https://github.com/benprew/pony) / [Gmail](http://mail.google.com/)
* SMS is provided by [Twilio](http://www.twilio.com/) / [twiliolib](https://github.com/twilio/twilio-ruby)
* Phone number handing is provided by [Phone](https://github.com/carr/phone)
* Date formatting is provided by [Chronic](https://github.com/mojombo/chronic/)
* Markdown formatting is provided by [RDiscount](https://github.com/rtomayko/rdiscount)
* JavaScript libraries provided by [jQuery](http://jquery.com/)
