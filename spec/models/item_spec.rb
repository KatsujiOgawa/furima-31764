require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.build(:user) 
  end

  before do
    @item = FactoryBot.build(:item) 
  end

  describe '商品新規投稿機能' do
    context '新規登録ができる時' do
      it "全ての項目が正常であれば登録できる" do
        expect(@item).to be_valid
      end
    end

    context '新規登録できない時' do
      it "商品画像が１枚追加されていないと投稿できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "商品名が存在しないと投稿できない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "商品説明が存在しないと投稿できない" do
        @item.info = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it "価格情報が存在しないと投稿できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "価格情報が英字だと投稿できない" do
        @item.price = "aaaaa"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is failed")
      end
      it "価格情報が全角数字だと投稿できない" do
        @item.price = "３４４４４"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is failed")
      end
      it "価格情報がひらがなだと投稿できない" do
        @item.price = "あああああ"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is failed")
      end
      it "価格情報がカタカナだと投稿できない" do
        @item.price = "カタカナ"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is failed")
      end
      it "価格情報が漢字だと投稿できない" do
        @item.price = "漢字"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is failed")
      end
      it "価格情報が記号だと投稿できない" do
        @item.price = "?/<>@%"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is failed")
      end
      it "価格が¥299以下だと投稿できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is failed")
      end
      it "価格が¥10,000,000以上だと投稿できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is failed")
      end
      it "商品の状態が選択されていないと投稿できない。" do
        @item.condition_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 1")
      end
      it "配送料の負担者が選択されていないと投稿できない。" do
        @item.shipping_payer_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping payer must be other than 1")
      end
      it "配送元地域が選択されていないと投稿できない。" do
        @item.prefecture_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it "カテゴリーが選択されていないと投稿できない。" do
        @item.category_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it "配送日数が選択されていないと投稿できない。" do
        @item.shipping_day_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day must be other than 1")
      end
    end
  end
end