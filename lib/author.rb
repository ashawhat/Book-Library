class Author
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM author;")
    all_authors = []
    results.each do |result|
      name = result['author_name']
      id = result['id'].to_i
      all_authors << Author.new({'id' => id, 'name' => name})
    end
    all_authors
  end

  def ==(another_author)
    self.name == another_author.name && self.id == another_author.id
  end

  def save
    results = DB.exec("INSERT INTO author (author_name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
    # results = DB.exec("INSERT INTO authors_books (authors_id) VALUES ('#{@name}') RETURNING id;")
  end
end
