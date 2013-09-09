class AwesomeController < ActionController::Base

  def index
    render :text => "OK"
  end

  def send_email
    mail = AwesomeMailer.welcome
    mail.deliver

    render :text => "OK"
  end

end