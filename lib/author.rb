class Author < ActiveRecord::Base
  validates :first_name, presence: true, length: { minimum: 1 }
  validates :last_name, presence: true, length: { minimum: 1 }
  has_many :books
end
