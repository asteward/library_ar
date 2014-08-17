require 'bundler/setup'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def header
  system 'clear'
  puts "
 █▀▀▀█ █  █ █▀▀█ █▀▀ █▀▀█ 　  █     ▀  █▀▀▄ █▀▀█ █▀▀█ █▀▀█ █  █ 　  █▀▀▀█ █▀▀ █▀▀█ █▀▀█ █▀▀ █  █
 ▀▀▀▄▄ █  █ █  █ █▀▀ █▄▄▀ 　  █    ▀█▀ █▀▀▄ █▄▄▀ █▄▄█ █▄▄▀ █▄▄█ 　  ▀▀▀▄▄ █▀▀ █▄▄█ █▄▄▀ █   █▀▀█
 █▄▄▄█  ▀▀▀ █▀▀▀ ▀▀▀ ▀ ▀▀ 　  █▄▄█ ▀▀▀ ▀▀▀  ▀ ▀▀ ▀  ▀ ▀ ▀▀ ▄▄▄█ 　  █▄▄▄█ ▀▀▀ ▀  ▀ ▀ ▀▀ ▀▀▀ ▀  ▀
 \n\n"
end
