class Item < ApplicationRecord
  belongs_to :user
  has_one :buy
  has_one_attached :image

  validates :image, presence: true
  with_options presence: true, format: { with: /\A[0-9]+\z/} do
    validates :price
  end
    validates :price, numericality: { greater_than_or_equal_to: 300,less_than_or_equal_to: 9999999, message: "is failed" }
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_payer
  belongs_to :prefecture
  validates :name, presence: true
  validates :info, presence: true
  validates :category_id, numericality: { other_than: 1 } 
  validates :condition_id, numericality: { other_than: 1 }
  validates :shipping_payer_id, numericality: { other_than: 1 }
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :shipping_day_id,  numericality: { other_than: 1 }
end