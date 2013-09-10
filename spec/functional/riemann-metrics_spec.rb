require 'spec_helper'

describe AwesomeController, :type => :controller do

  context 'given a rails application' do

    it 'should collect metrics for process_action_action_controller' do
      Riemann::Metrics::Client.any_instance.should_receive(:gauge).with(
        ["AwesomeController", "index", "http_status"],
        "ok",
        200,
        "AwesomeController.index.http_status"
      )
      Riemann::Metrics::Client.any_instance.should_receive(:gauge).with(
        ["AwesomeController", "index", "view_runtime"],
        "ok",
        anything(),
        "AwesomeController.index.view_runtime"
      )
      Riemann::Metrics::Client.any_instance.should_receive(:gauge).with(
        ["AwesomeController", "index", "request_runtime"],
        "ok",
        anything(),
        "AwesomeController.index.total_time"
      )
      Riemann::Metrics::Client.any_instance.should_receive(:gauge).with(
        ["AwesomeController", "index", "db_runtime"],
        "ok",
        nil,
        "AwesomeController.index.db_runtime"
      )

      get 'index'
    end

    it 'should collect metrics for deliver_action_mailer' do
      Riemann::Metrics::Client.any_instance.should_receive(:gauge).with(
        ["AwesomeMailer", "email_send_runtime"],
        "ok",
        anything(),
        "AwesomeMailer.email_send_runtime"
      )

      get 'send_email'
    end

    it 'should allow for custom metric collection' do
      Riemann::Metrics::Client.any_instance.should_receive(:gauge).with(
        ["custom", "tag"],
        "ok",
        1,
        "my-awesome-metric"
      )
      Riemann::Metrics::Client.any_instance.should_receive(:gauge).with(
        ["custom", "tag"],
        "ok",
        anything(),
        "my-awesome-timed-metric"
      )

      get 'custom_metrics'
    end

  end

end