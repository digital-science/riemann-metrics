# Riemann::Metrics

Riemann::Metrics is an opinionated Rails engine for forwarding ActiveSupport::Notifications to a Riemann server. It's opinionated in that it makes some assumptions about what a Riemann event should look like.

## Installation

Add this line to your application's Gemfile:

    gem 'riemann-metrics'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install riemann-metrics

## Configuration

Create an initializer in your application's config/initializers directory. 

````ruby
MyApp::Application.configure do
  config.riemann_metrics.enabled = true                 # set to false to disable metrics collection
  config.riemann_metrics.service_name = 'my-rails-app'  # the name of your application / service
  config.riemann_metrics.host = 'localhost'             # the host of your Riemann server
  config.riemann_metrics.port = 5555                    # the port of your Riemann server
  config.riemann_metrics.ttl = 5                        # the TTL for metrics sent to Riemann
  config.riemann_metrics.riemann_env = Rails.env        # environment to tag metrics with, defaults to Rails.env
end
````

## Usage

### Rails Metrics

By default Riemann::Metrics will subscribe to the following channels provided by ActiveSupport::Notifications:

* process_action.action_controller

The following metrics will be generated for a given process_action.action_controller event:

http_status - the HTTP status of a given request
````
{
	:host=>"Georges-MacBook-Air.local", 
	:state=>"ok", 
	:metric=>200, 
	:ttl=>5, 
	:tags=>["Api::InstitutionsController", "index", "http_status", "development"], 
	:service=>"my-rails-app.Api::InstitutionsController.index.http_status"
}
````

view_runtime - the time taken rendering a view for a given request
````
{
	:host=>"Georges-MacBook-Air.local", 
	:state=>"ok", 
	:metric=>0.225, 
	:ttl=>5, 
	:tags=>["Api::InstitutionsController", "index", "view_runtime", "development"], 
	:service=>"my-rails-app.Api::InstitutionsController.index.view_runtime"
}
````

request_runtime - the total time taking handling a given request
````
{
	:host=>"Georges-MacBook-Air.local", 
	:state=>"ok", 
	:metric=>159.704, 
	:ttl=>5, 
	:tags=>["Api::InstitutionsController", "index", "request_runtime", "development"], 
	:service=>"my-rails-app.Api::InstitutionsController.index.total_time"
}
````

db_runtime - the time taken doing database queries for a given request
````
{
	:host=>"Georges-MacBook-Air.local", 
	:state=>"ok", 
	:metric=>39.528999999999996, 
	:ttl=>5, 
	:tags=>["Api::InstitutionsController", "index", "db_runtime", "development"],
	:service=>"my-rails-app.Api::InstitutionsController.index.db_runtime"
}
````

The state will be 'ok' unless an exception is present in the ActiveSupport::Notification payload, in which case it will be 'critical'.

* deliver.action_mailer

The following metric will be generated for a deliver.action_mailer event:

````
{
	:host=>"Georges-MacBook-Air.local", 
	:state=>"ok", 
	:metric=>2000.0330000000001, 
	:ttl=>5, 
	:tags=>["AwesomeMailer", "email_send_runtime", "test"], 
	:service=>"Rails.AwesomeMailer.email_send_runtime"
}
````

email_send_runtime - the time taken to send a given email

The state will be 'ok' unless an exception is present in the ActiveSupport::Notification payload, in which case it will be 'critical'.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
