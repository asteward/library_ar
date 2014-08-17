class Book < ActiveRecord::Base
  belongs_to :author
  validates :title, presence: true, length: { minimum: 1 }
  before_save :capitalize_title
  scope :great_books, -> { where(author_id: (Author.find_by first_name: 'George', last_name: 'Orwell').id) }

private
  def capitalize_title
    self.title = self.title.scan(/(\w{1,}|.)/).each {|x| x.first.capitalize!}.join
  end
end
