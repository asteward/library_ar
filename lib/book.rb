class Book < ActiveRecord::Base
  belongs_to :author
  validates :title, presence: true, length: { minimum: 1 }
end
