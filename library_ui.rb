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

def main_menu
  header
  puts "A > Author Menu"
  puts "B > Book Menu" if (Author.all.length > 0)
  puts "E > Exit\n"
  print "Please select a menu option: "
  choice = gets.chomp.upcase
  (choice = "z") if ((Author.all.length == 0) && (choice == "B"))
  case (choice)
  when 'A'
    author_menu
  when 'B'
    book_menu
  when 'E'
    puts "Have an excellent day!"
    exit
  else
    puts "Invalid menu option. Try again."
    sleep 1.5
  end
  main_menu
end
main_menu
