Rails.application.routes.draw do
  get 'index' => "awesome#index"
  get 'send_email' => "awesome#send_email"
end
