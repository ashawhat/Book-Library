require 'rspec'
require 'pg'
require 'book'
require 'author'
require 'pry'
require 'catalog'


DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM author *;")
    DB.exec("DELETE FROM authors_books *;")
  end
end
