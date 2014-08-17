class Author < ActiveRecord::Base
  has_many :books
  validates :first_name, presence: true, length: { minimum: 1 }
  validates :last_name, presence: true, length: { minimum: 1 }
  before_save :capitalize_name


private
  def capitalize_name
    first_name.capitalize!
    last_name.capitalize!
  end
end
