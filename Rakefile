$:.unshift File.dirname(__FILE__) + '/lib'
require 'hire'

desc 'Start an IRB session with the `Hire` module loaded'
task :console do
  require 'irb'
  ARGV.clear
  IRB.start
end

desc 'Book a week'
task :book, [:start_day] do |t, args|
  require 'chronic'
  start_date = Chronic.parse(args[:start_day])
  end_date = Chronic.parse('next Friday', now: start_date)
  Hire.redis[start_date.strftime('%b %e').gsub(/\s+/, ' ')] = true
  puts "Week #{start_date.strftime('%b %e').gsub(/\s+/, ' ')}–#{end_date.strftime('%b %e').gsub(/\s+/, ' ')} booked."
end
