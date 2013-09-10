class AwesomeController < ActionController::Base

  def index
    render :text => "OK"
  end

  def send_email
    mail = AwesomeMailer.welcome
    mail.deliver

    render :text => "OK"
  end

  def custom_metrics
    Riemann::Metrics.instrument "my-awesome-metric", ["custom","tag"], "ok", 1
    Riemann::Metrics.instrument "my-awesome-timed-metric", ["custom","tag"], "ok", 1 do
      sleep 2
    end

    render :text => "OK"
  end

end