require './lib/author'

# DB = PG.connect({:dbname => 'library'})

class Book

attr_reader :title, :author, :id

  def initialize(title, author, id=nil)
    @title = title
    @author = author
    @id = id
  end

  def self.all
    results = DB.exec("SELECT * FROM books;")
    all_books = []
      results.each do |result|
        title = result['title']
        author = result['authors_name']
        id = result['id'].to_i
        all_books << Book.new(title, author, id)
      end
      all_books
    end

  def ==(argument)
  self.title == argument.title && self.id == argument.id && self.author == argument.author
end

  def save
    results = DB.exec("INSERT INTO books (title, authors_name) VALUES ('#{@title}', '#{@author}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def add_author(author_name)
    new_author = Author.new({'name' => author_name})
    new_author.save
    author_id = new_author.id
    puts author_id
    DB.exec("INSERT INTO authors_books (authors_id, books_id) VALUES ('#{author_id}', '#{id}');")
  end

  def delete
    book_to_delete = DB.exec("DELETE FROM books WHERE id = #{id};")
  end
end
