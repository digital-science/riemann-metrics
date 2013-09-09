require 'rubygems'
require 'bundler/setup'

require 'combustion'

Combustion.initialize! :action_controller, :action_view, :active_model, :action_mailer

require 'rspec/rails'