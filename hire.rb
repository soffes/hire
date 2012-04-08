class Hire < Sinatra::Base
  configure do
    Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.rb'))
  end
  
  get '/stylesheets/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss(:"stylesheets/#{params[:name]}.css", Compass.sass_engine_options )
  end
  
  get '/' do
    @weeks = []
    start_date = Chronic.parse('next Monday')
    end_date = Chronic.parse('next Sunday', now: start_date)
    
    10.times do |i|
      @weeks << {
        booked: false,
        start_date: start_date.strftime('%b %e'),
        end_date: end_date.strftime('%b %e')
      }
      
      start_date = Chronic.parse('next Monday', now: end_date)
      end_date = Chronic.parse('next Sunday', now: start_date)
    end
    
    @weeks[3][:booked] = true
    
    erb :index, locals: { weeks: @weeks }
  end
end
