class Article < ApplicationRecord
  acts_as_votable
  searchkick
  has_many :comments, dependent: :destroy
end
