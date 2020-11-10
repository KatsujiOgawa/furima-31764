class Item < ApplicationRecord
  belongs_to :user
  has_one :buy
  has_one_attached :image


  with_options presence: true, format: { with: /\A[0-9]+\z/} do
    validates :price
  end

  validates :price, numericality: { greater_than_or_equal_to: 300,less_than_or_equal_to: 9999999, message: "is failed" }
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_payer
  belongs_to :prefecture

  with_options presence: true do
    validates :name, :info, :image
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id, :condition_id, :shipping_payer_id, :prefecture_id, :shipping_day_id
  end
end