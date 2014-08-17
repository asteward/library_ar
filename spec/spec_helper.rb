require 'bundler/setup'
Bundler.require(:default, :test)

require 'author'
require 'book'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Author.all.each { |task| task.destroy }
    Book.all.each { |task| task.destroy }
  end
end
