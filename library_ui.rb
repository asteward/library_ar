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
    author_menu
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

def list_authors
  header
  puts "All authors___________"
  Author.order(:last_name).each {|author| puts "#{author.last_name}, #{author.first_name}"}
  print "\nPress ENTER to continue..."
  gets
end

def book_menu
  header
  puts "A > Add Book"
  puts "L > List All Books"
  puts "S > Search Books by Author"
  puts "R > Return to Main Menu"
  case gets.chomp.upcase
  when 'A'
    add_book
  when 'L'
    list_books
  when 'S'
    search_books
  when 'R'
  else
    puts "Invalid menu option. Try again."
    sleep 1.5
    book_menu
  end
end

def add_book
  header
  list_authors
  puts "Please enter book author's first name:"
  f_name = gets.chomp.capitalize
  puts "Please enter book author's last name:"
  l_name = gets.chomp.capitalize
  author = Author.find_by first_name: f_name, last_name: l_name
  if author
    puts "Please enter book\'s title:"
    title = gets.chomp
    new_book = author.books.create({title: title})
    if new_book.save
      puts "#{author.first_name} #{author.last_name}'s #{new_book.title} has been added!"
      print "\nPress ENTER to continue..."
      gets
    else
      puts "An error occurred. Please be sure to enter a book title."
      print "\nPress ENTER to continue..."
      gets
      add_author
    end
  else
    puts "An error occurred. Please be sure to correctly enter the author's first and last name."
    puts "Also, be sure that author is listed in database."
    print "\nPress ENTER to continue..."
    gets
    add_author
  end
end

def list_books
  header
  puts "All books___________"
  Book.order(:title).each do |book|
    author = Author.find(book.author_id)
    puts "#{book.title}, by #{author.first_name} #{author.last_name}"
  end
  print "\nPress ENTER to continue..."
  gets
end


main_menu
