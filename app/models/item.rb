class Item < ApplicationRecord
  belongs_to :user
  has_one :buy
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  validates :category_id, numericality: { other_than: 1 } 
  validates :condition_id, numericality: { other_than: 1}
end
