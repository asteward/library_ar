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
  case choice
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

def author_menu
  header
  puts "A > Add Author"
  puts "L > List All Authors"
  puts "R > Return to Main Menu"
  case gets.chomp.upcase
  when 'A'
    add_author
  when 'L'
    list_authors
  when 'R'
  else
    puts "Invalid menu option. Try again."
    sleep 1.5
  end
end

def add_author
  header
  puts "Please enter Author\'s first name:"
  f_name = gets.chomp
  puts "Please enter Author\'s last name:"
  l_name = gets.chomp
  new_author = Author.create({first_name: f_name, last_name: l_name})
  if new_author.save
    puts "#{new_author.first_name} #{new_author.last_name} has been added!"
    print "\nPress ENTER to continue..."
    gets
  else
    puts "An error occurred. Please be sure to enter a first AND last name."
    print "\nPress ENTER to continue..."
    gets
    add_author
  end
end
main_menu
