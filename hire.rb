ENV['REDISTOGO_URL'] = 'redis://localhost:6379' unless ENV['REDISTOGO_URL']
uri = URI.parse(ENV['REDISTOGO_URL'])
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

class Hire < Sinatra::Base
  get '/' do
    erb :index
  end
end
