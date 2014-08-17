require 'spec_helper'

describe Book do
  it { should belong_to(:author) }

  it 'validates the presence of a title for the book' do
    author = Author.create({first_name: "George", last_name: "Orwell"})
    book = author.books.create({title: ""})
    expect(Book.all).to eq []
    book = author.books.create({title: "Nineteen Eighty-Four"})
    expect(Book.all).to eq [book]
  end
end
