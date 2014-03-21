require 'spec_helper'

describe 'Catalog' do
  it 'initializes a new instance of Catalog' do
    test_catalog = Catalog.new
    test_catalog.should be_an_instance_of Catalog
  end
end
