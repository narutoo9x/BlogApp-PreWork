class Tag < ApplicationRecord
  has_many :taggings
  has_many :articles, through: :taggings

  # def self.counts
  #   self.select("name, count(taggings.tag_id) as count").
  #     joins(:taggings).group("tags.id")
  # end
  def self.counts
    self.select("name , count(taggings.tag_id) as count").
      joins(:taggings).group("id")
  end
end
