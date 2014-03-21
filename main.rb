require 'pg'
require './lib/book.rb'

DB = PG.connect({:dbname => 'library'})

def title
  puts "Knowledge is Power - Welcome to Your Local Conceptual Library"
  puts "Designed by Apple, in California!"
  main_menu
end

def main_menu
  puts "Tell us if you are a Intelligent Librarian OR a Bookworm"
  puts "For Librarians, enter 'l'"
  puts "For Bookworms, enter 'b'"
  puts "Press 'x' to Exit"
user_input = gets.chomp
case user_input
    when 'l'
      librarian_menu
    when 'b'
      patron_menu
    when 'x'
      puts "Exiting System..."
    else
      main_menu
  end
end


def librarian_menu
  puts "Here are your options:"
  puts "'a' to add a book"
  puts "'v' to view books"
  puts "'s' to search for a book"
  puts "'m' to return to main menu"
  user_input = gets.chomp
case user_input
  when 'a'
    add_book
  when 'v'
    view_books
  when 'm'
    main_menu
  when 's'
    search_start
  else
    main_menu
  end
end

def search_start
  puts "Do you want to search by Author (press 'a') or Title (press 't')"
  user_input = gets.chomp
  case user_input
  when 'a'
    search_by_author
  when 't'
    search_by_title
  else main_menu
  end
end

def search_by_author
  puts "Enter the Author to search by:"
  author_search = gets.chomp
  puts "These are the books by '#{author_search}'"
end

def patron_menu
  puts "Here are your options:"
  puts "'v' to view books"
  puts "'m' to return to main_menu"
user_input = gets.chomp
case user_input
    when 'v'
      view_books
    when 'm'
      main_menu
    else
      main_menu
  end
end

def add_book
    puts "Enter the title of your book here:"
    book_title = gets.chomp
    puts "Enter the author of the book:"
    author_name = gets.chomp
    new_book = Book.new(book_title, author_name)
    new_book.save
    puts "You have entered '#{book_title} by '#{author_name} to The Most Amazing Library"
    puts "to view your Book Collection press 'v' or 'm' tp return to main menu"
    user_input = gets.chomp
    case user_input
    when 'v'
      view_books
    when 'm'
    main_menu
  else main_menu
  end
end

def view_books
  puts "Here are all of the books currently stored in The Most Amazing Library"
  all_books = Book.all
  all_books.each_with_index do |book, index|
    puts "#{index + 1}. #{book.title} by #{book.author}"
  end
  puts "to add an author, press 'a'"
  puts "to delete a book, press 'd' "
  user_input = gets.chomp
  case user_input
    when "d"
      puts "Type the number of the book you would like to delete"
      current_book = gets.chomp.to_i
      delete_current_book(current_book)
    when "a"
      puts "Type the number of the book you would like to an an author for"
      current_book = gets.chomp.to_i
      add_author(current_book)
  end
  main_menu
end

def delete_current_book(current_book)
  puts "Entered the delete function!"
  all_books = Book.all
  all_books[current_book-1].delete
  puts "Book deleted!"
end

def add_author(current_book)
  puts "Entered the add book function in the UI!!"
  puts "Now, please enter the name of the author!"
  author_name = gets.chomp
  all_books = Book.all
  all_books[current_book-1].add_author(author_name)
  puts "AUTHOR ADDED"
  main_menu
end

title
