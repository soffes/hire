require 'bundler'
Bundler.require

# Canonical Host
use Rack::CanonicalHost, ENV['CANONICAL_HOST'] if ENV['CANONICAL_HOST']

# Assets
map '/assets' do
  sprockets = Sprockets::Environment.new
  sprockets.append_path 'assets/javascripts'
  sprockets.append_path 'assets/stylesheets'
  run sprockets
end

# App
$:.unshift File.dirname(__FILE__) + '/lib'
require 'hire'
require 'hire/application'
run Hire::Application
