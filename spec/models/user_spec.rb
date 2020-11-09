require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user) 
  end

  describe 'ユーザー新規登録' do

    context '新規登録がうまくいくとき' do
      it "nicknameが空欄でなければ登録できる" do
        expect(@user).to be_valid
      end
      it "emailが空欄でなく、@を含み、同じemailが存在しないと登録できる" do
        @user.email = "ogawa111ogawa@docomo.ne.jp"
        expect(@user).to be_valid
      end
      it "passwordと確認用passwordが空欄でなく、半角英数混合の６文字以上で入力されていると登録できる" do
        @user.password = "aaa111"
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it "first_nameとlast_nameが空欄ではなく、全角(ひらがな・カタカナ・漢字)であれば登録できる" do
        @user.first_name = "かナ郎"
        @user.last_name = "かナ山"
        expect(@user).to be_valid
      end
      it "first_name_katakanaとlast_name_katakanaが空欄ではなく、全角(カタカナ)であれば登録できる" do
        @user.first_name_katakana = "カナロウ"
        @user.last_name_katakana = "カナヤマ"
        expect(@user).to be_valid
      end
      it "birthday_idが空欄でなければ登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空だと登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "emailが@を含んでいないと登録できない" do
        @user.email = "aaaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "passwordが空だと登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下だとと登録できない" do
        @user.password = "kkk00"
        @user.password_confirmation = "kkk00"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが数字のみだと登録できない" do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      
      it "passwordが英字のみだと登録できない" do
        @user.password = "kkkkkk"
        @user.password_confirmation = "kkkkkk"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      it "password_confirmarionが空だと登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "password_confirmationがpasswordと一致しないと登録できない" do
        @user.password = "kkk001"
        @user.password_confirmation = "kkk000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "first_nameが空だと登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "first_nameが英字だと登録できない" do
        @user.first_name = "eiji"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name Full-width characters")
      end
      it "first_nameが数字だと登録できない" do
        @user.first_name = "2222"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name Full-width characters")
      end
      it "first_nameが記号だと登録できない" do
        @user.first_name = "+={}<>/"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name Full-width characters")
      end
      it "last_nameが空だと登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "last_nameが英字だと登録できない" do
        @user.last_name = "eiji"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name Full-width characters")
      end
      it "last_nameが数字だと登録できない" do
        @user.last_name = "2222"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name Full-width characters")
      end
      it "last_nameが記号だと登録できない" do
        @user.last_name = "+={}<>/"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name Full-width characters")
      end
      it "first_name_katakanaが空だと登録できない" do
        @user.first_name_katakana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana can't be blank")
      end
      it "first_name_katakanaが漢字だと登録できない" do
        @user.first_name_katakana = "漢字"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana Full-width katakana characters")
      end
      it "first_name_katakanaがひらがなだと登録できない" do
        @user.first_name_katakana = "ひらがな"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana Full-width katakana characters")
      end
      it "first_name_katakanaが英字だと登録できない" do
        @user.first_name_katakana = "eiji"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana Full-width katakana characters")
      end
      it "first_name_katakanaが数字だと登録できない" do
        @user.first_name_katakana = "2222"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana Full-width katakana characters")
      end
      it "first_name_katakanaが記号だと登録できない" do
        @user.first_name_katakana = "+={}<>/"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana Full-width katakana characters")
      end
      it "last_nmae_katakanaが空だと登録できない" do
        @user.last_name_katakana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana can't be blank")
      end
      it "last_name_katakanaが漢字だと登録できない" do
        @user.last_name_katakana = "漢字"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana Full-width katakana characters")
      end
      it "last_name_katakanaがひらがなだと登録できない" do
        @user.last_name_katakana = "ひらがな"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana Full-width katakana characters")
      end
      it "last_name_katakanaが英字だと登録できない" do
        @user.last_name_katakana = "eiji"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana Full-width katakana characters")
      end
      it "last_name_katakanaが数字だと登録できない" do
        @user.last_name_katakana = "2222"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana Full-width katakana characters")
      end
      it "last_name_katakanaが記号だと登録できない" do
        @user.last_name_katakana = "+={}<>/"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana Full-width katakana characters")
      end
      it "birthday_idが空だと登録できない" do
        @user.birthday_id = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      
    end
  end
end