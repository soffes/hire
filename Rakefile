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
  Hire.redis[args[:start_day]] = true
end
