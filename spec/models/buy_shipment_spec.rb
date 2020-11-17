require 'rails_helper'

RSpec.describe BuyShipment, type: :model do
  before do
    @user = FactoryBot.create(:user) 
  end
  before do
    @item = FactoryBot.create(:item) 
    sleep 0.3
  end
  before do
    @buy_shipment = FactoryBot.build(:buy_shipment, user_id: @user.id, item_id: @item.id)
  end

  context "購入情報が保存できるとき" do
    it "tokenと配送情報が記入されていれば保存できる" do
      expect(@buy_shipment).to be_valid
    end

    it "building_nameが空でも、他の情報が正しければ保存できる" do
      @buy_shipment.building_name = ""
      expect(@buy_shipment).to be_valid
    end
  end

  context "購入情報が保存できないとき" do
    it "postal_codeが空だと保存できない" do
      @buy_shipment.postal_code = ""
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Postal code can't be blank")
    end
    it "postal_codeがハイフンを含まないと保存できない" do
      @buy_shipment.postal_code = "1234567"
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end
    it "postal_codeが英字だと保存できない" do
      @buy_shipment.postal_code = "abc-defg"
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end
    it "postal_codeがひらがなだと保存できない" do
      @buy_shipment.postal_code = "あいう-えおかき"
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end
    it "postal_codeがカタカナだと保存できない" do
      @buy_shipment.postal_code = "アイウ-エオカキ"
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end
    it "postal_codeが記号だと保存できない" do
      @buy_shipment.postal_code = "/;$-<<+="
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end
    it "postal_codeが３桁-４桁でないと保存できない" do
      @buy_shipment.postal_code = "1234-12345"
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end
    it "prefecture_idが1だと保存できない" do
      @buy_shipment.prefecture_id = "1"
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Prefecture can't be blank")
    end
    it "cityが空だと保存できない" do
      @buy_shipment.city = ""
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("City can't be blank")
    end
    it "house_numberが空だと保存できない" do
      @buy_shipment.house_number = ""
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("House number can't be blank")
    end
    it "phone_numberが空だと保存できない" do
      @buy_shipment.phone_number = ""
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Phone number can't be blank")
    end
    it "phone_numberにハイフンがあると保存できない" do
      @buy_shipment.phone_number = "045-124-678"
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Phone number is half-width number without hyphen(-)")
    end
    it "phone_numberが英字だと保存できない" do
      @buy_shipment.phone_number = "abcdefghijk"
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Phone number is half-width number without hyphen(-)")
    end
    it "phone_numberがひらがなだと保存できない" do
      @buy_shipment.phone_number = "あいうえおかきくけこさ"
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Phone number is half-width number without hyphen(-)")
    end
    it "phone_numberがカタカナだと保存できない" do
      @buy_shipment.phone_number = "アイウエオカキクケコサ"
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Phone number is half-width number without hyphen(-)")
    end
    it "phone_numberが漢字だと保存できない" do
      @buy_shipment.phone_number = "零八零一二三四五六七八"
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Phone number is half-width number without hyphen(-)")
    end
    it "phone_numberが記号だと保存できない" do
      @buy_shipment.phone_number = "?!#$%^&%%<>"
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Phone number is half-width number without hyphen(-)")
    end
    it "tokenが空だと保存できない" do
      @buy_shipment.token = nil
      @buy_shipment.valid?
      expect(@buy_shipment.errors.full_messages).to include("Token can't be blank")
    end
   
  end
end
