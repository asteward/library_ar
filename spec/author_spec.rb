require 'spec_helper'

describe 'Author' do
  it 'validates the presence of a first and last name for the author' do
    author = Author.create({first_name: "", last_name: ""})
    expect(Author.all).to eq []
    author = Author.create({first_name: "George", last_name: "Orwell"})
    expect(Author.all).to eq [author]
  end


end
