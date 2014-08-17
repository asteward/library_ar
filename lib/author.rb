class Author < ActiveRecord::Base
  validates :first_name, presence: true, length: { minimum: 1 }
  validates :last_name, presence: true, length: { minimum: 1 }
  before_save :capitalize_name
  has_many :books


private
  def capitalize_name
    first_name.capitalize!
    last_name.capitalize!
  end
end
