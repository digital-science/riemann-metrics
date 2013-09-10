Riemann::Metrics.subscribe "my-awesome-metric" do |client, channel, start, finish, id, payload|
  tags = payload[:tags]
  state = payload[:state]
  metric = payload[:metric]

  client.gauge tags, state, metric, "my-awesome-metric"
end

Riemann::Metrics.subscribe "my-awesome-timed-metric" do |client, channel, start, finish, id, payload|
  tags = payload[:tags]
  state = payload[:state]
  total_time = ( finish - start ) * 1000

  client.gauge tags, state, total_time, "my-awesome-timed-metric"
end