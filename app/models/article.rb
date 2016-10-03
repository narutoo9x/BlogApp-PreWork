class Article < ApplicationRecord
  acts_as_votable
  searchkick
  is_impressionable
  
  # title can't be blank
  validates :title, presence: true, length: { maximum: 64 }
  validates :body, presence: true

  has_many :comments, dependent: :destroy
  has_many :taggings , dependent: :destroy
  has_many :tags, through: :taggings


  def self.tagged_with(name)
    Tag.find_by!(name: name).articles
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end
end
