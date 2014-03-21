require 'spec_helper'

describe 'Book' do
  it "creates an instance of book" do
    test_book = Book.new('test', 'test')
    test_book.should be_an_instance_of Book
  end
  it "is initialized with the book title" do
    test_book = Book.new("Where the Wild Things Are", "Maurice W.", 5)
    test_book.title.should eq "Where the Wild Things Are"
  end
  it "saves a new book to the database" do
    test_book = Book.new("Where the Wild Things Are", "Maurice W.", 5)
    test_book.save
    Book.all.should eq [test_book]
  end

  it "starts off as an empty array" do
    Book.all.should eq []
  end

  it "doesn't freak when things have the same name" do
   test_book1 = Book.new("Old Man in the Sea", "Hemmingway", 4)
   test_book2 = Book.new("Old Man in the Sea", "Hemmingway", 4)
   test_book1.should eq test_book2
  end

  describe 'delete' do
    it "removes a book from the database... FOREVER!!" do
      test_book = Book.new("Where the Wild Things Are", "Maurice W.", 5)
      test_book.save
      test_book.delete
      Book.all.should eq []
    end
  end

  describe 'add_author' do
    it 'adds an author to this book' do
      test_book = Book.new("On The Road")
      test_book.save
      test_author = Author.new({'name' => 'Jack Kerouac'})
      test_author.save
      test_book.add_author(test_author)
      results = DB.exec("SELECT * FROM authors_books WHERE book_id = #{test_book.id};")
      results.first['author_id'].should eq test_author.id
    end
  end
end
