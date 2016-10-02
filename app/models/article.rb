class Article < ApplicationRecord
  acts_as_votable
  searchkick
  is_impressionable
  has_many :comments, dependent: :destroy
end
