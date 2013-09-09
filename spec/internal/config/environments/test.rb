class CustomDelivery

  def initialize(*)
  end

  def deliver!(mail)
    Riemann::Metrics.gauge ["deliver.action_mailer", Time.now-2.seconds, Time.now, nil, {:mailer=>"AwesomeMailer", :message_id=>nil, :subject=>"We like to spamalot!", :to=>["text@example.com"], :from=>["no-reply@example.com"], :date=>nil, :mail=>"Date: Mon, 09 Sep 2013 16:29:27 +0100\r\nFrom: no-reply@example.com\r\nTo: text@example.com\r\nMessage-ID: <522de957a8245_93363fcfb88606d873096@Georges-MacBook-Air.local.mail>\r\nSubject: We like to spamalot!\r\nMime-Version: 1.0\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\nHello"}]
  end

end

Combustion::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_assets  = true
  config.static_cache_control = "public, max-age=3600"

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = CustomDelivery

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr
end
