class Article < ApplicationRecord
  acts_as_votable
  has_many :comments
end
