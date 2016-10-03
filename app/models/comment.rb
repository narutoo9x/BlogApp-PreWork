class Comment < ApplicationRecord
  validates :name, presence: :true
  validates :comment, presence: :true, length: { maximum: 144 }
  
  belongs_to :article
end
