require 'riemann'

module Riemann
  module Metrics
    class Client

      OK        = "ok"
      CRITICAL  = "critical"
      WARNING   = "warning"
      STATES    = [OK,CRITICAL,WARNING]

      TTL = 10

      def initialize host, port, service_name, riemann_env, ttl
        @host = host
        @port = port
        @service_name = service_name
        @ttl = ttl || TTL
        @riemann_env = riemann_env || 'none'
        @hostname = get_hostname
      end

      def client
        @riemann_client ||= Riemann::Client.new(host: @host, port: @port)
      end

      def gauge tags, state, metric, service='', description=nil
        event = {
          host: @hostname,
          state: state,
          metric: metric,
          ttl: @ttl,
          tags: (tags.dup << @riemann_env),
          service: "#{@service_name}.#{service}"
        }
        event[:description] = description if description
        Rails.logger.debug "Notifying: #{event.inspect}"
        client << event
      end

      def get_hostname
        `hostname`.strip
      end

    end

  end

end