module Riemann
  module Metrics
    class NotificationsHandler

      attr_reader :client

      def initialize client
        @client = client
      end

      def total_time start, finish
        ( finish - start ) * 1000
      end

      def process_action_action_controller channel, start, finish, id, payload
        tags = [payload[:controller], payload[:action]]
        service_name = tags.join(".")
        state = !payload[:exception].nil? ? Riemann::Metrics::Client::CRITICAL : Riemann::Metrics::Client::OK
        client.gauge (tags.dup << 'http_status'), state, payload[:status], "#{service_name}.http_status"
        client.gauge (tags.dup << 'view_runtime'), state, payload[:view_runtime], "#{service_name}.view_runtime"
        client.gauge (tags.dup << 'request_runtime'), state, total_time(start, finish), "#{service_name}.total_time"
        client.gauge (tags.dup << 'db_runtime'), state, payload[:db_runtime], "#{service_name}.db_runtime"
      end

      def deliver_action_mailer channel, start, finish, id, payload
        tags = [ payload[:mailer] ]
        state = !payload[:exception].nil? ? Riemann::Metrics::Client::CRITICAL : Riemann::Metrics::Client::OK
        client.gauge (tags.dup << 'email_send_runtime'), state, total_time(start, finish), "#{payload[:mailer]}.email_send_runtime"
      end

    end

  end

end