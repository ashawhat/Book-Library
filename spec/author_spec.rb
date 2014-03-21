require 'spec_helper'

describe 'Author' do
  describe 'inititialize' do
    it "inititializes a new instance of author" do
      test_author = Author.new({'name' => 'Stephen King'})
      test_author.should be_an_instance_of Author
    end
  end
  it "starts off as an empty array" do
    Author.all.should eq []
  end
  it "saves a new author to the database" do
    test_author = Author.new({'name' => 'Stephen King'})
    test_author.save
    Author.all.should eq [test_author]
  end
end
