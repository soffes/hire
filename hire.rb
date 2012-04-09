ENV['REDISTOGO_URL'] = 'redis://localhost:6379' unless ENV['REDISTOGO_URL']
uri = URI.parse(ENV['REDISTOGO_URL'])
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

class Hire < Sinatra::Base
  get '/' do
    @weeks = []
    start_date = Chronic.parse('Monday', context: :past)
    end_date = Chronic.parse('next Sunday', now: start_date)
    today = Time.now
    
    10.times do |i|
      start_string = start_date.strftime('%b %e').gsub('  ', ' ')
      @weeks << {
        booked: (end_date < today or $redis.get(start_string)),
        start_date: start_string,
        end_date: end_date.strftime('%b %e').gsub('  ', ' ')
      }
      
      start_date = Chronic.parse('next Monday', now: end_date)
      end_date = Chronic.parse('next Sunday', now: start_date)
    end
    
    erb :index, locals: { weeks: @weeks }
  end
end
