class BuyShipment
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do  
    validates :prefecture_id, :city, :house_number, :phone_number, :user_id, :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :phone_number, format: {with: /\A[0-9]{0,11}\z/, message: "is half-width number without hyphen(-)"}
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    @buy = Buy.create(user_id: user_id, item_id: item_id)
    @shipment = Shipment.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, buy_id: @buy.id)
  end
end